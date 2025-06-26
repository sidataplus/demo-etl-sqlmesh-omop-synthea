AUDIT (
  name person_completeness_device_exposure,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.DEVICE_EXPOSURE AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name device_exposure_device_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  DEVICE_CONCEPT_ID IS NULL;

AUDIT (
  name device_exposure_device_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEVICE_EXPOSURE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DEVICE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DEVICE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name device_exposure_device_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
JOIN omop.concept AS c
  ON t.DEVICE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Device';

AUDIT (
  name device_exposure_device_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
LEFT JOIN omop.concept AS c
  ON t.DEVICE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.DEVICE_CONCEPT_ID IS NULL
  AND t.DEVICE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name device_exposure_device_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  DEVICE_CONCEPT_ID = 0;

AUDIT (
  name device_exposure_device_exposure_end_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.DEVICE_EXPOSURE_END_DATE < p.birth_datetime;

AUDIT (
  name device_exposure_device_exposure_end_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.DEVICE_EXPOSURE_END_DATETIME < p.birth_datetime;

AUDIT (
  name device_exposure_device_exposure_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  DEVICE_EXPOSURE_ID IS NULL;

AUDIT (
  name device_exposure_device_exposure_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  DEVICE_EXPOSURE_ID,
  COUNT(*)
FROM omop.DEVICE_EXPOSURE
WHERE
  NOT DEVICE_EXPOSURE_ID IS NULL
GROUP BY
  DEVICE_EXPOSURE_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name device_exposure_device_exposure_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  DEVICE_EXPOSURE_START_DATE IS NULL;

AUDIT (
  name device_exposure_device_exposure_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  DEVICE_EXPOSURE_START_DATE > DEVICE_EXPOSURE_END_DATE;

AUDIT (
  name device_exposure_device_exposure_start_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.DEVICE_EXPOSURE_START_DATE < p.birth_datetime;

AUDIT (
  name device_exposure_device_exposure_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  DEVICE_EXPOSURE_START_DATETIME > DEVICE_EXPOSURE_END_DATETIME;

AUDIT (
  name device_exposure_device_exposure_start_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.DEVICE_EXPOSURE_START_DATETIME < p.birth_datetime;

AUDIT (
  name device_exposure_device_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEVICE_EXPOSURE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DEVICE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DEVICE_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name device_exposure_device_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  DEVICE_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name device_exposure_device_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEVICE_EXPOSURE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DEVICE_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DEVICE_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name device_exposure_device_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
JOIN omop.concept AS c
  ON t.DEVICE_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name device_exposure_device_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
LEFT JOIN omop.concept AS c
  ON t.DEVICE_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.DEVICE_TYPE_CONCEPT_ID IS NULL
  AND t.DEVICE_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name device_exposure_device_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  DEVICE_TYPE_CONCEPT_ID = 0;

AUDIT (
  name device_exposure_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name device_exposure_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEVICE_EXPOSURE AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name device_exposure_provider_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEVICE_EXPOSURE AS c
LEFT JOIN omop.PROVIDER AS p
  ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE
  NOT c.PROVIDER_ID IS NULL AND p.PROVIDER_ID IS NULL;

AUDIT (
  name device_exposure_unit_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEVICE_EXPOSURE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.UNIT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name device_exposure_unit_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
JOIN omop.concept AS c
  ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Unit';

AUDIT (
  name device_exposure_unit_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEVICE_EXPOSURE AS t
LEFT JOIN omop.concept AS c
  ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE
  NOT t.UNIT_CONCEPT_ID IS NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name device_exposure_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEVICE_EXPOSURE
WHERE
  UNIT_CONCEPT_ID = 0;

AUDIT (
  name device_exposure_unit_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEVICE_EXPOSURE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.UNIT_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.UNIT_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name device_exposure_visit_detail_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEVICE_EXPOSURE AS c
LEFT JOIN omop.VISIT_DETAIL AS p
  ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE
  NOT c.VISIT_DETAIL_ID IS NULL AND p.VISIT_DETAIL_ID IS NULL;

AUDIT (
  name device_exposure_visit_occurrence_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEVICE_EXPOSURE AS c
LEFT JOIN omop.VISIT_OCCURRENCE AS p
  ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE
  NOT c.VISIT_OCCURRENCE_ID IS NULL AND p.VISIT_OCCURRENCE_ID IS NULL