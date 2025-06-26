AUDIT (
  name person_completeness_payer_plan_period,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.PAYER_PLAN_PERIOD AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name payer_plan_period_payer_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PAYER_PLAN_PERIOD AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.PAYER_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.PAYER_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name payer_plan_period_payer_plan_period_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PAYER_PLAN_PERIOD
WHERE
  PAYER_PLAN_PERIOD_END_DATE IS NULL;

AUDIT (
  name payer_plan_period_payer_plan_period_end_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PAYER_PLAN_PERIOD AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PAYER_PLAN_PERIOD_END_DATE < p.birth_datetime;

AUDIT (
  name payer_plan_period_payer_plan_period_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PAYER_PLAN_PERIOD
WHERE
  PAYER_PLAN_PERIOD_ID IS NULL;

AUDIT (
  name payer_plan_period_payer_plan_period_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  PAYER_PLAN_PERIOD_ID,
  COUNT(*)
FROM omop.PAYER_PLAN_PERIOD
WHERE
  NOT PAYER_PLAN_PERIOD_ID IS NULL
GROUP BY
  PAYER_PLAN_PERIOD_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name payer_plan_period_payer_plan_period_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PAYER_PLAN_PERIOD
WHERE
  PAYER_PLAN_PERIOD_START_DATE IS NULL;

AUDIT (
  name payer_plan_period_payer_plan_period_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PAYER_PLAN_PERIOD
WHERE
  PAYER_PLAN_PERIOD_START_DATE > PAYER_PLAN_PERIOD_END_DATE;

AUDIT (
  name payer_plan_period_payer_plan_period_start_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PAYER_PLAN_PERIOD AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PAYER_PLAN_PERIOD_START_DATE < p.birth_datetime;

AUDIT (
  name payer_plan_period_payer_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PAYER_PLAN_PERIOD AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.PAYER_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.PAYER_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name payer_plan_period_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PAYER_PLAN_PERIOD
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name payer_plan_period_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PAYER_PLAN_PERIOD AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name payer_plan_period_plan_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PAYER_PLAN_PERIOD AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.PLAN_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.PLAN_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name payer_plan_period_plan_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PAYER_PLAN_PERIOD AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.PLAN_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.PLAN_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name payer_plan_period_sponsor_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PAYER_PLAN_PERIOD AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.SPONSOR_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.SPONSOR_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name payer_plan_period_sponsor_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PAYER_PLAN_PERIOD AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.SPONSOR_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.SPONSOR_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name payer_plan_period_stop_reason_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PAYER_PLAN_PERIOD AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.STOP_REASON_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.STOP_REASON_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name payer_plan_period_stop_reason_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PAYER_PLAN_PERIOD AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.STOP_REASON_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.STOP_REASON_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL