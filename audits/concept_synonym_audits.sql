AUDIT (
  name concept_synonym_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_SYNONYM
WHERE
  CONCEPT_ID IS NULL;

AUDIT (
  name concept_synonym_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT_SYNONYM AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name concept_synonym_concept_synonym_name_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_SYNONYM
WHERE
  CONCEPT_SYNONYM_NAME IS NULL;

AUDIT (
  name concept_synonym_language_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_SYNONYM
WHERE
  LANGUAGE_CONCEPT_ID IS NULL;

AUDIT (
  name concept_synonym_language_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT_SYNONYM AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.LANGUAGE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.LANGUAGE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL