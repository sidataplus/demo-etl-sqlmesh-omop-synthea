# generate_sqlmesh_audits.py

A **one‑shot generator** that converts OHDSI/DataQualityDashboard `Table_Level`,
`Field_Level`, and `Concept_Level` CSV files into per‑table **SQLMesh `AUDIT`
blocks**. Drop the generated SQL next to your models and wire the audit names
into the `MODEL(... audits ())`; no manual SQL hand‑crafting required.

---

## Key Features

The script generates audits based on rules defined in the DQD CSV files.

### Table-Level Audits (`*Table_Level.csv`)

| Rule Column (CSV)           | Audit Type                  |
|-----------------------------|-----------------------------|
| `isRequired`                | Checks that the table exists. |
| `measurePersonCompleteness` | Checks for persons missing from an event table. |

### Field-Level Audits (`*Field_Level.csv`)

| Rule Column (CSV)                     | Audit Type                             |
|---------------------------------------|----------------------------------------|
| `isRequired`                          | Checks for NULLs in a required field.  |
| `isPrimaryKey`                        | Checks for duplicate values in a primary key. |
| `isForeignKey`                        | Checks for orphaned foreign keys.      |
| `fkDomain`                            | Checks concept's domain matches the expected domain. |
| `isStandardValidConcept`              | Checks if a concept is standard and valid. |
| `standardConceptRecordCompleteness`   | Checks for concept ID 0 (source records not mapped to a standard concept). |
| `plausibleStartBeforeEndFieldName`    | Checks that start dates are before end dates. |
| `plausibleAfterBirth`                 | Checks that event dates are after person's birth date. |

### Concept-Level Audits (`*Concept_Level.csv`)

| Rule Column (CSV)                 | Audit Type                                      |
|-----------------------------------|-------------------------------------------------|
| `validPrevalenceLow` / `...High`  | Concept prevalence is within bounds.            |
| `plausibleValueLow` / `...High`   | Numeric value is within plausible range.        |
| `plausibleGender`                 | Concept is plausible for patient's gender.      |
| `plausibleGenderUseDescendants`   | Descendants of concept are plausible for patient's gender. |
| `plausibleUnitConceptIds`         | Concept's unit is in the list of plausible units. |
| `isTemporallyConstant`            | Value is constant for a person over time.       |

---

## Installation

```bash
# Requires Python ≥3.8 and pandas ≥2.0
pip install pandas
```

---

## Usage

```bash
python generate_sqlmesh_audits.py path/to/your/dqd/csv -o ../audits/
```

* **Input:** A directory containing DQD CSV files (`*Table_Level.csv`,
  `*Field_Level.csv`, and `*Concept_Level.csv`) from
  [OHDSI/DataQualityDashboard](https://github.com/OHDSI/DataQualityDashboard/tree/main/inst/csv).
* **Output:** One `<table>_audits.sql` per CDM table inside the output directory (default: `audits/`).
  Each file begins with a commented helper snippet showing the audit names to
  paste into your SQLMesh `MODEL` definition.

### Example integration

```sql
-- your_model.sql
MODEL (
  name omop.procedure_occurrence,
  kind INCREMENTAL_BY_TIME_RANGE (time_column procedure_date),
  audits (
    procedure_occurrence_2109916_gender,
    procedure_occurrence_4041261_gender
  )
);

WITH main AS (
  ...
)
SELECT * FROM main;
```

---

## Customization

* **Numeric columns** to check for low/high plausibility are mapped via
  `NUMERIC_FIELD_MAP` inside the script. Extend the dict if you store numeric
  values in additional CDM tables.
* **Blocking:** audits default to `blocking false`. Flip the `BLOCKING`
  constant to `true` if you want failing audits to abort materialization.
* **Dialect:** set `DIALECT` to `duckdb`/`postgres` etc. if you use a different
  engine.
