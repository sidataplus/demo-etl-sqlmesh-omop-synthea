AUDIT (
  name cohort_cohort_definition_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COHORT
WHERE
  COHORT_DEFINITION_ID IS NULL;

AUDIT (
  name cohort_cohort_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COHORT
WHERE
  COHORT_END_DATE IS NULL;

AUDIT (
  name cohort_cohort_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COHORT
WHERE
  COHORT_START_DATE IS NULL;

AUDIT (
  name cohort_subject_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COHORT
WHERE
  SUBJECT_ID IS NULL