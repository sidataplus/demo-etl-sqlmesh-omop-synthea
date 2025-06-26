AUDIT (
  name vocabulary_vocabulary_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VOCABULARY
WHERE
  VOCABULARY_CONCEPT_ID IS NULL;

AUDIT (
  name vocabulary_vocabulary_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VOCABULARY AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VOCABULARY_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VOCABULARY_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name vocabulary_vocabulary_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VOCABULARY
WHERE
  VOCABULARY_ID IS NULL;

AUDIT (
  name vocabulary_vocabulary_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  VOCABULARY_ID,
  COUNT(*)
FROM omop.VOCABULARY
WHERE
  NOT VOCABULARY_ID IS NULL
GROUP BY
  VOCABULARY_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name vocabulary_vocabulary_name_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VOCABULARY
WHERE
  VOCABULARY_NAME IS NULL