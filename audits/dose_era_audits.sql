AUDIT (
  name person_completeness_dose_era,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.DOSE_ERA AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name dose_era_dose_era_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  DOSE_ERA_END_DATE IS NULL;

AUDIT (
  name dose_era_dose_era_end_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DOSE_ERA AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.DOSE_ERA_END_DATE < p.birth_datetime;

AUDIT (
  name dose_era_dose_era_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  DOSE_ERA_ID IS NULL;

AUDIT (
  name dose_era_dose_era_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  DOSE_ERA_ID,
  COUNT(*)
FROM omop.DOSE_ERA
WHERE
  NOT DOSE_ERA_ID IS NULL
GROUP BY
  DOSE_ERA_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name dose_era_dose_era_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  DOSE_ERA_START_DATE IS NULL;

AUDIT (
  name dose_era_dose_era_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  DOSE_ERA_START_DATE > DOSE_ERA_END_DATE;

AUDIT (
  name dose_era_dose_era_start_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DOSE_ERA AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.DOSE_ERA_START_DATE < p.birth_datetime;

AUDIT (
  name dose_era_dose_value_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  DOSE_VALUE IS NULL;

AUDIT (
  name dose_era_drug_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  DRUG_CONCEPT_ID IS NULL;

AUDIT (
  name dose_era_drug_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DOSE_ERA AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DRUG_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DRUG_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name dose_era_drug_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DOSE_ERA AS t
JOIN omop.concept AS c
  ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Drug';

AUDIT (
  name dose_era_drug_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DOSE_ERA AS t
LEFT JOIN omop.concept AS c
  ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE
  NOT t.DRUG_CONCEPT_ID IS NULL
  AND t.DRUG_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name dose_era_drug_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  DRUG_CONCEPT_ID = 0;

AUDIT (
  name dose_era_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name dose_era_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DOSE_ERA AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name dose_era_unit_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  UNIT_CONCEPT_ID IS NULL;

AUDIT (
  name dose_era_unit_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DOSE_ERA AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.UNIT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name dose_era_unit_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DOSE_ERA AS t
JOIN omop.concept AS c
  ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Unit';

AUDIT (
  name dose_era_unit_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DOSE_ERA AS t
LEFT JOIN omop.concept AS c
  ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE
  NOT t.UNIT_CONCEPT_ID IS NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name dose_era_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOSE_ERA
WHERE
  UNIT_CONCEPT_ID = 0