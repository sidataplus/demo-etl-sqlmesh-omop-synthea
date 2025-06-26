#!/usr/bin/env python3

import argparse
import pathlib
import re
import sys
import textwrap
from collections import defaultdict
from typing import Dict, Iterable, List

import pandas as pd

# ───────────────────────── CONFIG ────────────────────────── #
# Maps table names to the column containing numeric values for plausibility checks
NUMERIC_FIELD_MAP = {
    "MEASUREMENT": "value_as_number",
    "OBSERVATION": "value_as_number",
}
# Maps table names to the column containing concept values for temporality checks
CONCEPT_VALUE_MAP = {
    "OBSERVATION": "value_as_concept_id",
    "MEASUREMENT": "value_as_concept_id",
}
# Maps gender names to their standard OMOP concept IDs
GENDER_MAP = {
    "FEMALE": 8532,
    "MALE": 8507,
}
# SQLMesh Audit configuration
DIALECT = "duckdb"
BLOCKING = "false"
# Default OMOP schema name
SCHEMA = "omop"

# Helper to create a file-safe slug from a string
_slug = lambda s: re.sub(r"[^0-9A-Za-z_]+", "_", s).lower()


# ───────────────────── SQL TEMPLATES ─────────────────────── #

# ----------------- Audit Wrapper ----------------- #
def audit_block(name: str, sql_body: str, description: str) -> str:
    """Wraps a SQL query in a SQLMesh AUDIT block."""
    return textwrap.dedent(
        f"""
        -- Description: {description}
        AUDIT (
          name {_slug(name)},
          dialect {DIALECT},
          blocking {BLOCKING}
        );
        {sql_body};

        """
    ).lstrip()

# ----------------- Table Level SQL ----------------- #

def table_exists_sql(tbl: str) -> str:
    """An audit that fails if the specified table does not exist."""
    # This audit passes (returns 0 rows) if the table exists, and fails to execute if it doesn't.
    return f"SELECT 1 FROM {SCHEMA}.{tbl} WHERE 1 = 0"

def person_completeness_sql(event_tbl: str) -> str:
    """Checks for persons in the PERSON table who are missing from an event table."""
    return textwrap.dedent(
        f"""
        SELECT p.person_id
        FROM {SCHEMA}.person p
        LEFT JOIN {SCHEMA}.{event_tbl} e ON p.person_id = e.person_id
        WHERE e.person_id IS NULL;
        """
    ).strip()

# ----------------- Field Level SQL ----------------- #

def is_required_sql(tbl: str, fld: str) -> str:
    """Checks for NULL values in a field that is specified as required."""
    return f"SELECT * FROM {SCHEMA}.{tbl} WHERE {fld} IS NULL"

def is_primary_key_sql(tbl: str, pk_fld: str) -> str:
    """Checks for duplicate values in a primary key field."""
    return textwrap.dedent(
        f"""
        SELECT {pk_fld}, COUNT(*)
        FROM {SCHEMA}.{tbl}
        WHERE {pk_fld} IS NOT NULL
        GROUP BY {pk_fld}
        HAVING COUNT(*) > 1;
        """
    ).strip()

def is_foreign_key_sql(child_tbl: str, fk_fld: str, parent_tbl: str, pk_fld: str) -> str:
    """Checks for foreign key values that do not exist in the referenced parent table."""
    return textwrap.dedent(
        f"""
        SELECT c.*
        FROM {SCHEMA}.{child_tbl} c
        LEFT JOIN {SCHEMA}.{parent_tbl} p ON c.{fk_fld} = p.{pk_fld}
        WHERE c.{fk_fld} IS NOT NULL AND p.{pk_fld} IS NULL;
        """
    ).strip()

def fk_domain_sql(tbl: str, concept_fld: str, expected_domain: str) -> str:
    """Checks if a foreign key concept's domain matches the expected domain."""
    return textwrap.dedent(
        f"""
        SELECT t.*
        FROM {SCHEMA}.{tbl} t
        JOIN {SCHEMA}.concept c ON t.{concept_fld} = c.concept_id
        WHERE c.domain_id <> '{expected_domain}';
        """
    ).strip()

def is_standard_valid_concept_sql(tbl: str, concept_fld: str) -> str:
    """Checks if a concept ID is a standard, valid concept."""
    return textwrap.dedent(
        f"""
        SELECT t.*
        FROM {SCHEMA}.{tbl} t
        LEFT JOIN {SCHEMA}.concept c ON t.{concept_fld} = c.concept_id
        WHERE t.{concept_fld} IS NOT NULL
          AND t.{concept_fld} <> 0
          AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL);
        """
    ).strip()

def concept_record_completeness_sql(tbl: str, concept_fld: str) -> str:
    """Checks for records where a standard concept ID is 0."""
    return f"SELECT * FROM {SCHEMA}.{tbl} WHERE {concept_fld} = 0"

def plausible_start_before_end_sql(tbl: str, start_fld: str, end_fld: str) -> str:
    """Checks that a start date/datetime comes before an end date/datetime."""
    return f"SELECT * FROM {SCHEMA}.{tbl} WHERE {start_fld} > {end_fld}"

def plausible_after_birth_sql(tbl: str, date_fld: str) -> str:
    """Checks that an event date comes after the person's birth date."""
    return textwrap.dedent(
        f"""
        SELECT t.*
        FROM {SCHEMA}.{tbl} t
        JOIN {SCHEMA}.person p ON t.person_id = p.person_id
        WHERE t.{date_fld} < p.birth_datetime;
        """
    ).strip()

# ----------------- Concept Level SQL (from previous version, unchanged) ----------------- #

def prevalence_sql(tbl: str, fld: str, cid: int, comp: str, thr) -> str:
    return textwrap.dedent(
        f"""
        WITH concept_cnt AS (
            SELECT COUNT(*) n FROM {SCHEMA}.{tbl} WHERE {fld} = {cid}
        ), total_cnt AS (
            SELECT COUNT(*) n FROM {SCHEMA}.{tbl}
        )
        SELECT '{tbl}' AS table_name, {cid} AS concept_id
        FROM concept_cnt c CROSS JOIN total_cnt t
        WHERE (c.n::FLOAT / NULLIF(t.n, 0)) {comp} {thr};
        """
    ).strip()

def plausibility_sql(tbl: str, fld: str, cid: int, num_col: str, comp: str, bound, unit_cid=None) -> str:
    unit_check_sql = ""
    if unit_cid is not None and pd.notna(unit_cid):
        if tbl.upper() in ["MEASUREMENT", "OBSERVATION"]:
            unit_check_sql = f"AND unit_concept_id = {int(unit_cid)}"
    return textwrap.dedent(
        f"""
        SELECT *
        FROM {SCHEMA}.{tbl}
        WHERE {fld} = {cid}
          {unit_check_sql}
          AND {num_col} {comp} {bound};
        """
    ).strip()

def temporality_sql(tbl: str, fld: str, cid: int) -> str:
    value_fld = CONCEPT_VALUE_MAP.get(tbl.upper())
    if value_fld:
        # Check for changing values for concepts that should be constant (e.g., in OBSERVATION)
        return textwrap.dedent(
            f"""
            SELECT person_id, COUNT(DISTINCT {value_fld}) AS num_distinct_values
            FROM {SCHEMA}.{tbl}
            WHERE {fld} = {cid}
              AND {value_fld} IS NOT NULL
            GROUP BY person_id
            HAVING COUNT(DISTINCT {value_fld}) > 1;
            """
        ).strip()
    else:
        # Check for multiple occurrences of concepts that should appear only once (e.g., in CONDITION_OCCURRENCE)
        return textwrap.dedent(
            f"""
            SELECT person_id, COUNT(*) AS num_records
            FROM {SCHEMA}.{tbl}
            WHERE {fld} = {cid}
            GROUP BY person_id
            HAVING COUNT(*) > 1;
            """
        ).strip()

def plausible_gender_sql(tbl: str, fld: str, cid: int, gender_flag: str, use_descendants: bool) -> str:
    gender_id = GENDER_MAP.get(str(gender_flag).upper())
    if gender_id is None: return ""
    concept_check_sql = f"""t.{fld} IN (
            SELECT descendant_concept_id FROM {SCHEMA}.concept_ancestor WHERE ancestor_concept_id = {cid}
        )""" if use_descendants else f"t.{fld} = {cid}"
    return textwrap.dedent(
        f"""
        SELECT t.*
        FROM {SCHEMA}.{tbl} t
        JOIN {SCHEMA}.person p ON t.person_id = p.person_id
        WHERE {concept_check_sql}
          AND p.gender_concept_id <> {gender_id};
        """
    ).strip()

def plausible_unit_sql(tbl: str, fld: str, cid: int, allowed_unit_ids: Iterable[int]) -> str:
    ids = list(allowed_unit_ids)
    if not ids: return ""
    in_list = ", ".join(map(str, ids))
    return textwrap.dedent(
        f"""
        SELECT *
        FROM {SCHEMA}.{tbl}
        WHERE {fld} = {cid}
          AND unit_concept_id NOT IN ({in_list});
        """
    ).strip()


# ───────────────────────── HELPERS ────────────────────────── #

def parse_id_list(raw) -> List[int]:
    if pd.isna(raw):
        return []
    return [int(float(t)) for t in re.split(r"[ ,;|]+", str(raw)) if t.replace('.', '', 1).isdigit()]

# ────────────────────── BUILD AUDITS ─────────────────────── #

def build_audits_for_table_level(csv_path: pathlib.Path) -> Dict[str, list]:
    df = pd.read_csv(csv_path)
    df.columns = [c.strip() for c in df.columns]
    audits = defaultdict(list)

    for _, row in df.iterrows():
        tbl = str(row.cdmTableName).upper()

        if str(row.get("isRequired", "")).lower() == "yes":
            desc = f"Check if table '{tbl}' exists."
            audits[tbl].append((f"{tbl}_exists", audit_block(f"{tbl}_exists", table_exists_sql(tbl), desc)))

        if str(row.get("measurePersonCompleteness", "")).lower() == "yes":
            desc = f"Check for persons missing from table '{tbl}'."
            audits[tbl].append((f"person_completeness_{tbl}", audit_block(f"person_completeness_{tbl}", person_completeness_sql(tbl), desc)))
            
    return audits

def build_audits_for_field_level(csv_path: pathlib.Path) -> Dict[str, list]:
    df = pd.read_csv(csv_path)
    df.columns = [c.strip() for c in df.columns]
    audits = defaultdict(list)

    for _, row in df.iterrows():
        tbl = str(row.cdmTableName).upper()
        fld = str(row.cdmFieldName).upper()

        if str(row.get("isRequired", "")).lower() == "yes":
            desc = f"Check for NULLs in required field '{tbl}.{fld}'."
            audits[tbl].append((f"{tbl}_{fld}_is_required", audit_block(f"{tbl}_{fld}_is_required", is_required_sql(tbl, fld), desc)))
            
        if str(row.get("isPrimaryKey", "")).lower() == "yes":
            desc = f"Check for duplicate values in primary key field '{tbl}.{fld}'."
            audits[tbl].append((f"{tbl}_{fld}_is_primary_key", audit_block(f"{tbl}_{fld}_is_primary_key", is_primary_key_sql(tbl, fld), desc)))

        if str(row.get("isForeignKey", "")).lower() == "yes" and pd.notna(row.get("fkTableName")):
            parent_tbl = str(row.fkTableName).upper()
            parent_fld = str(row.fkFieldName).upper()
            desc = f"Check for orphaned foreign keys in '{tbl}.{fld}' pointing to '{parent_tbl}.{parent_fld}'."
            audits[tbl].append((f"{tbl}_{fld}_is_foreign_key", audit_block(f"{tbl}_{fld}_is_foreign_key", is_foreign_key_sql(tbl, fld, parent_tbl, parent_fld), desc)))

        if pd.notna(row.get("fkDomain")):
            desc = f"Check that concepts in '{tbl}.{fld}' belong to the '{row.fkDomain}' domain."
            audits[tbl].append((f"{tbl}_{fld}_fk_domain", audit_block(f"{tbl}_{fld}_fk_domain", fk_domain_sql(tbl, fld, row.fkDomain), desc)))

        if str(row.get("isStandardValidConcept", "")).lower() == "yes":
            desc = f"Check that concepts in '{tbl}.{fld}' are standard and valid."
            audits[tbl].append((f"{tbl}_{fld}_is_standard_valid_concept", audit_block(f"{tbl}_{fld}_is_standard_valid_concept", is_standard_valid_concept_sql(tbl, fld), desc)))
        
        if str(row.get("standardConceptRecordCompleteness", "")).lower() == "yes":
            desc = f"Check for concept ID 0 in standard concept field '{tbl}.{fld}'."
            audits[tbl].append((f"{tbl}_{fld}_standard_concept_record_completeness", audit_block(f"{tbl}_{fld}_standard_concept_record_completeness", concept_record_completeness_sql(tbl, fld), desc)))
            
        if pd.notna(row.get("plausibleStartBeforeEndFieldName")):
            end_fld = str(row.plausibleStartBeforeEndFieldName).upper()
            desc = f"Check that '{tbl}.{fld}' occurs before '{tbl}.{end_fld}'."
            audits[tbl].append((f"{tbl}_{fld}_start_before_end", audit_block(f"{tbl}_{fld}_start_before_end", plausible_start_before_end_sql(tbl, fld, end_fld), desc)))
            
        if str(row.get("plausibleAfterBirth", "")).lower() == "yes":
            desc = f"Check that date '{tbl}.{fld}' is after person's birth date."
            audits[tbl].append((f"{tbl}_{fld}_after_birth", audit_block(f"{tbl}_{fld}_after_birth", plausible_after_birth_sql(tbl, fld), desc)))
            
    return audits

def build_audits_for_concept_level(csv_path: pathlib.Path) -> Dict[str, list]:
    df = pd.read_csv(csv_path)
    df.columns = [c.strip() for c in df.columns]
    audits = defaultdict(list)

    for _, row in df.iterrows():
        tbl = str(row.cdmTableName).upper()
        fld = str(row.cdmFieldName).upper()

        for cid in parse_id_list(row.conceptId):
            cname = str(row.get("conceptName", "")).strip() or f"concept_id {cid}"
            
            # Valid Prevalence
            if pd.notna(row.get("validPrevalenceLow")):
                desc = f"Prevalence of concept '{cname}' in '{tbl}' is below {row.validPrevalenceLow}."
                audits[tbl].append((f"{tbl}_{cid}_valid_low", audit_block(f"{tbl}_{cid}_valid_low", prevalence_sql(tbl, fld, cid, "<", row.validPrevalenceLow), desc)))
            if pd.notna(row.get("validPrevalenceHigh")):
                desc = f"Prevalence of concept '{cname}' in '{tbl}' is above {row.validPrevalenceHigh}."
                audits[tbl].append((f"{tbl}_{cid}_valid_high", audit_block(f"{tbl}_{cid}_valid_high", prevalence_sql(tbl, fld, cid, ">", row.validPrevalenceHigh), desc)))

            # Plausible numeric range
            num_col, unit_cid = NUMERIC_FIELD_MAP.get(tbl), row.get("unitConceptId")
            if num_col and pd.notna(row.get("plausibleValueLow")):
                desc = f"Plausible value for '{cname}' is below {row.plausibleValueLow}."
                audits[tbl].append((f"{tbl}_{cid}_{unit_cid or 'any'}_low", audit_block(f"{tbl}_{cid}_{unit_cid or 'any'}_low", plausibility_sql(tbl, fld, cid, num_col, "<", row.plausibleValueLow, unit_cid), desc)))
            if num_col and pd.notna(row.get("plausibleValueHigh")):
                desc = f"Plausible value for '{cname}' is above {row.plausibleValueHigh}."
                audits[tbl].append((f"{tbl}_{cid}_{unit_cid or 'any'}_high", audit_block(f"{tbl}_{cid}_{unit_cid or 'any'}_high", plausibility_sql(tbl, fld, cid, num_col, ">", row.plausibleValueHigh, unit_cid), desc)))

            # Plausible gender
            if pd.notna(row.get("plausibleGender")):
                desc = f"Gender check for concept '{cname}'."
                sql = plausible_gender_sql(tbl, fld, cid, row.plausibleGender, False)
                if sql: audits[tbl].append((f"{tbl}_{cid}_gender", audit_block(f"{tbl}_{cid}_gender", sql, desc)))
            if pd.notna(row.get("plausibleGenderUseDescendants")):
                desc = f"Gender check for descendants of concept '{cname}'."
                sql = plausible_gender_sql(tbl, fld, cid, row.plausibleGenderUseDescendants, True)
                if sql: audits[tbl].append((f"{tbl}_{cid}_gender_desc", audit_block(f"{tbl}_{cid}_gender_desc", sql, desc)))

            # Plausible unit
            unit_raw = (row.get("plausibleUnitConceptIds") or row.get("plausibleUnit"))
            if pd.notna(unit_raw) and (unit_ids := parse_id_list(unit_raw)):
                desc = f"Plausible unit check for concept '{cname}'."
                audits[tbl].append((f"{tbl}_{cid}_unit", audit_block(f"{tbl}_{cid}_unit", plausible_unit_sql(tbl, fld, cid, unit_ids), desc)))

            # Temporality
            if str(row.get("isTemporallyConstant", "")).lower() in {"yes", "true", "1"}:
                desc = f"Temporal constancy check for concept '{cname}'."
                audits[tbl].append((f"{tbl}_{cid}_temp", audit_block(f"{tbl}_{cid}_temp", temporality_sql(tbl, fld, cid), desc)))

    return audits

# ───────────────────────── WRITE FILES ─────────────────────── #

def write_audits(audits_by_table: dict, out_dir: pathlib.Path):
    """Writes all generated audit blocks to files, one per CDM table."""
    out_dir.mkdir(parents=True, exist_ok=True)

    for tbl, name_block_pairs in audits_by_table.items():
        if not name_block_pairs: continue
        
        # Deduplicate audit blocks based on their generated name
        seen = set()
        unique_blocks = []
        for name, block in name_block_pairs:
            if name not in seen:
                seen.add(name)
                unique_blocks.append(block)

        # Create a helper comment for SQLMesh model definitions
        helper_names = [m.group(1) for b in unique_blocks if (m := re.search(r"\bname (\w+)", b))]
        helper = (
            "-- ── COPY AND PASTE INTO YOUR MODEL DEFINITION ───────────\n"
            "-- MODEL (\n"
            f"--   name {SCHEMA}.{tbl.lower()},\n"
            "--   audits (\n"
            + "".join(f"--     {n},\n" for n in helper_names)
            + "--   )\n-- );\n\n"
        )

        path = out_dir / f"{tbl.lower()}_audits.sql"
        path.write_text(helper + "".join(unique_blocks), encoding="utf-8")
        print(f"Wrote {path} • {len(unique_blocks)} audits (deduped from {len(name_block_pairs)})")

# ───────────────────────────── CLI ──────────────────────────── #

def main():
    parser = argparse.ArgumentParser(description="Generate SQLMesh AUDIT blocks from DataQualityDashboard CSVs.")
    parser.add_argument("csv_dir", type=pathlib.Path, help="Path to directory containing DQD CSV files")
    parser.add_argument("-o", "--out-dir", type=pathlib.Path, default=pathlib.Path("audits"), help="Output directory")
    args = parser.parse_args()

    # Find CSV files in the directory
    try:
        table_csv_path = next(args.csv_dir.glob("*Table_Level.csv"))
    except StopIteration:
        print(f"Error: Could not find a file ending with 'Table_Level.csv' in '{args.csv_dir}'.")
        sys.exit(1)

    try:
        field_csv_path = next(args.csv_dir.glob("*Field_Level.csv"))
    except StopIteration:
        print(f"Error: Could not find a file ending with 'Field_Level.csv' in '{args.csv_dir}'.")
        sys.exit(1)

    try:
        concept_csv_path = next(args.csv_dir.glob("*Concept_Level.csv"))
    except StopIteration:
        print(f"Error: Could not find a file ending with 'Concept_Level.csv' in '{args.csv_dir}'.")
        sys.exit(1)


    # Build audits for each level
    table_audits = build_audits_for_table_level(table_csv_path)
    field_audits = build_audits_for_field_level(field_csv_path)
    concept_audits = build_audits_for_concept_level(concept_csv_path)

    # Merge all audits into a single dictionary keyed by table name
    merged_audits = defaultdict(list)
    for d in (table_audits, field_audits, concept_audits):
        for tbl, audit_list in d.items():
            merged_audits[tbl].extend(audit_list)

    # Write the combined audits to files
    write_audits(merged_audits, args.out_dir)

if __name__ == "__main__":
    main()
