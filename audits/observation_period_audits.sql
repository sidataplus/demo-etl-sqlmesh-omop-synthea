AUDIT (
  name observation_period_exists,
  dialect duckdb,
  blocking FALSE
);

SELECT
  1
FROM omop.OBSERVATION_PERIOD
WHERE
  1 = 0;

AUDIT (
  name person_completeness_observation_period,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.OBSERVATION_PERIOD AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name observation_period_observation_period_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION_PERIOD
WHERE
  OBSERVATION_PERIOD_END_DATE IS NULL;

AUDIT (
  name observation_period_observation_period_end_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION_PERIOD AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.OBSERVATION_PERIOD_END_DATE < p.birth_datetime;

AUDIT (
  name observation_period_observation_period_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION_PERIOD
WHERE
  OBSERVATION_PERIOD_ID IS NULL;

AUDIT (
  name observation_period_observation_period_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  OBSERVATION_PERIOD_ID,
  COUNT(*)
FROM omop.OBSERVATION_PERIOD
WHERE
  NOT OBSERVATION_PERIOD_ID IS NULL
GROUP BY
  OBSERVATION_PERIOD_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name observation_period_observation_period_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION_PERIOD
WHERE
  OBSERVATION_PERIOD_START_DATE IS NULL;

AUDIT (
  name observation_period_observation_period_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION_PERIOD
WHERE
  OBSERVATION_PERIOD_START_DATE > OBSERVATION_PERIOD_END_DATE;

AUDIT (
  name observation_period_observation_period_start_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION_PERIOD AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.OBSERVATION_PERIOD_START_DATE < p.birth_datetime;

AUDIT (
  name observation_period_period_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION_PERIOD
WHERE
  PERIOD_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name observation_period_period_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION_PERIOD AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.PERIOD_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.PERIOD_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name observation_period_period_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION_PERIOD AS t
JOIN omop.concept AS c
  ON t.PERIOD_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name observation_period_period_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION_PERIOD AS t
LEFT JOIN omop.concept AS c
  ON t.PERIOD_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.PERIOD_TYPE_CONCEPT_ID IS NULL
  AND t.PERIOD_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name observation_period_period_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION_PERIOD
WHERE
  PERIOD_TYPE_CONCEPT_ID = 0;

AUDIT (
  name observation_period_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION_PERIOD
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name observation_period_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION_PERIOD AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL