AUDIT (
  name concept_concept_class_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT
WHERE
  CONCEPT_CLASS_ID IS NULL;

AUDIT (
  name concept_concept_class_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT AS c
LEFT JOIN omop.CONCEPT_CLASS AS p
  ON c.CONCEPT_CLASS_ID = p.CONCEPT_CLASS_ID
WHERE
  NOT c.CONCEPT_CLASS_ID IS NULL AND p.CONCEPT_CLASS_ID IS NULL;

AUDIT (
  name concept_concept_code_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT
WHERE
  CONCEPT_CODE IS NULL;

AUDIT (
  name concept_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT
WHERE
  CONCEPT_ID IS NULL;

AUDIT (
  name concept_concept_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  CONCEPT_ID,
  COUNT(*)
FROM omop.CONCEPT
WHERE
  NOT CONCEPT_ID IS NULL
GROUP BY
  CONCEPT_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name concept_concept_name_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT
WHERE
  CONCEPT_NAME IS NULL;

AUDIT (
  name concept_domain_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT
WHERE
  DOMAIN_ID IS NULL;

AUDIT (
  name concept_domain_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT AS c
LEFT JOIN omop.DOMAIN AS p
  ON c.DOMAIN_ID = p.DOMAIN_ID
WHERE
  NOT c.DOMAIN_ID IS NULL AND p.DOMAIN_ID IS NULL;

AUDIT (
  name concept_valid_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT
WHERE
  VALID_END_DATE IS NULL;

AUDIT (
  name concept_valid_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT
WHERE
  VALID_START_DATE IS NULL;

AUDIT (
  name concept_valid_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT
WHERE
  VALID_START_DATE > VALID_END_DATE;

AUDIT (
  name concept_vocabulary_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT
WHERE
  VOCABULARY_ID IS NULL;

AUDIT (
  name concept_vocabulary_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT AS c
LEFT JOIN omop.VOCABULARY AS p
  ON c.VOCABULARY_ID = p.VOCABULARY_ID
WHERE
  NOT c.VOCABULARY_ID IS NULL AND p.VOCABULARY_ID IS NULL