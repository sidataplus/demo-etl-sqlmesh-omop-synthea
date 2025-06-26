AUDIT (
  name cohort_definition_cohort_definition_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COHORT_DEFINITION
WHERE
  COHORT_DEFINITION_ID IS NULL;

AUDIT (
  name cohort_definition_cohort_definition_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.COHORT_DEFINITION AS c
LEFT JOIN omop.COHORT AS p
  ON c.COHORT_DEFINITION_ID = p.COHORT_DEFINITION_ID
WHERE
  NOT c.COHORT_DEFINITION_ID IS NULL AND p.COHORT_DEFINITION_ID IS NULL;

AUDIT (
  name cohort_definition_cohort_definition_name_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COHORT_DEFINITION
WHERE
  COHORT_DEFINITION_NAME IS NULL;

AUDIT (
  name cohort_definition_definition_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COHORT_DEFINITION
WHERE
  DEFINITION_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name cohort_definition_definition_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.COHORT_DEFINITION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DEFINITION_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DEFINITION_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name cohort_definition_definition_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.COHORT_DEFINITION AS t
LEFT JOIN omop.concept AS c
  ON t.DEFINITION_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.DEFINITION_TYPE_CONCEPT_ID IS NULL
  AND t.DEFINITION_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name cohort_definition_subject_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COHORT_DEFINITION
WHERE
  SUBJECT_CONCEPT_ID IS NULL;

AUDIT (
  name cohort_definition_subject_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.COHORT_DEFINITION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.SUBJECT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.SUBJECT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name cohort_definition_subject_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.COHORT_DEFINITION AS t
LEFT JOIN omop.concept AS c
  ON t.SUBJECT_CONCEPT_ID = c.concept_id
WHERE
  NOT t.SUBJECT_CONCEPT_ID IS NULL
  AND t.SUBJECT_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  )