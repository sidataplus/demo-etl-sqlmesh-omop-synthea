AUDIT (
  name person_completeness_condition_era,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.CONDITION_ERA AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name condition_era_condition_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONDITION_ERA
WHERE
  CONDITION_CONCEPT_ID IS NULL;

AUDIT (
  name condition_era_condition_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONDITION_ERA AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.CONDITION_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.CONDITION_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name condition_era_condition_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.CONDITION_ERA AS t
JOIN omop.concept AS c
  ON t.CONDITION_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Condition';

AUDIT (
  name condition_era_condition_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.CONDITION_ERA AS t
LEFT JOIN omop.concept AS c
  ON t.CONDITION_CONCEPT_ID = c.concept_id
WHERE
  NOT t.CONDITION_CONCEPT_ID IS NULL
  AND t.CONDITION_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name condition_era_condition_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONDITION_ERA
WHERE
  CONDITION_CONCEPT_ID = 0;

AUDIT (
  name condition_era_condition_era_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONDITION_ERA
WHERE
  CONDITION_ERA_END_DATE IS NULL;

AUDIT (
  name condition_era_condition_era_end_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.CONDITION_ERA AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.CONDITION_ERA_END_DATE < p.birth_datetime;

AUDIT (
  name condition_era_condition_era_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONDITION_ERA
WHERE
  CONDITION_ERA_ID IS NULL;

AUDIT (
  name condition_era_condition_era_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  CONDITION_ERA_ID,
  COUNT(*)
FROM omop.CONDITION_ERA
WHERE
  NOT CONDITION_ERA_ID IS NULL
GROUP BY
  CONDITION_ERA_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name condition_era_condition_era_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONDITION_ERA
WHERE
  CONDITION_ERA_START_DATE IS NULL;

AUDIT (
  name condition_era_condition_era_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONDITION_ERA
WHERE
  CONDITION_ERA_START_DATE > CONDITION_ERA_END_DATE;

AUDIT (
  name condition_era_condition_era_start_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.CONDITION_ERA AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.CONDITION_ERA_START_DATE < p.birth_datetime;

AUDIT (
  name condition_era_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONDITION_ERA
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name condition_era_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONDITION_ERA AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL