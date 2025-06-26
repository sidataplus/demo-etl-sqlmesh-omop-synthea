AUDIT (
  name person_completeness_observation,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.OBSERVATION AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name observation_obs_event_field_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.OBS_EVENT_FIELD_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.OBS_EVENT_FIELD_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name observation_obs_event_field_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION AS t
LEFT JOIN omop.concept AS c
  ON t.OBS_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE
  NOT t.OBS_EVENT_FIELD_CONCEPT_ID IS NULL
  AND t.OBS_EVENT_FIELD_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name observation_observation_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID IS NULL;

AUDIT (
  name observation_observation_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.OBSERVATION_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.OBSERVATION_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name observation_observation_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION AS t
LEFT JOIN omop.concept AS c
  ON t.OBSERVATION_CONCEPT_ID = c.concept_id
WHERE
  NOT t.OBSERVATION_CONCEPT_ID IS NULL
  AND t.OBSERVATION_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name observation_observation_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 0;

AUDIT (
  name observation_observation_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_DATE IS NULL;

AUDIT (
  name observation_observation_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.OBSERVATION_DATE < p.birth_datetime;

AUDIT (
  name observation_observation_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.OBSERVATION_DATETIME < p.birth_datetime;

AUDIT (
  name observation_observation_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_ID IS NULL;

AUDIT (
  name observation_observation_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  OBSERVATION_ID,
  COUNT(*)
FROM omop.OBSERVATION
WHERE
  NOT OBSERVATION_ID IS NULL
GROUP BY
  OBSERVATION_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name observation_observation_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.OBSERVATION_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.OBSERVATION_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name observation_observation_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name observation_observation_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.OBSERVATION_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.OBSERVATION_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name observation_observation_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION AS t
JOIN omop.concept AS c
  ON t.OBSERVATION_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name observation_observation_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION AS t
LEFT JOIN omop.concept AS c
  ON t.OBSERVATION_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.OBSERVATION_TYPE_CONCEPT_ID IS NULL
  AND t.OBSERVATION_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name observation_observation_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_TYPE_CONCEPT_ID = 0;

AUDIT (
  name observation_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name observation_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name observation_provider_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.PROVIDER AS p
  ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE
  NOT c.PROVIDER_ID IS NULL AND p.PROVIDER_ID IS NULL;

AUDIT (
  name observation_qualifier_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.QUALIFIER_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.QUALIFIER_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name observation_qualifier_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION AS t
LEFT JOIN omop.concept AS c
  ON t.QUALIFIER_CONCEPT_ID = c.concept_id
WHERE
  NOT t.QUALIFIER_CONCEPT_ID IS NULL
  AND t.QUALIFIER_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name observation_unit_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.UNIT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name observation_unit_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION AS t
JOIN omop.concept AS c
  ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Unit';

AUDIT (
  name observation_unit_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.OBSERVATION AS t
LEFT JOIN omop.concept AS c
  ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE
  NOT t.UNIT_CONCEPT_ID IS NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name observation_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  UNIT_CONCEPT_ID = 0;

AUDIT (
  name observation_value_as_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VALUE_AS_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VALUE_AS_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name observation_visit_detail_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.VISIT_DETAIL AS p
  ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE
  NOT c.VISIT_DETAIL_ID IS NULL AND p.VISIT_DETAIL_ID IS NULL;

AUDIT (
  name observation_visit_occurrence_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.OBSERVATION AS c
LEFT JOIN omop.VISIT_OCCURRENCE AS p
  ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE
  NOT c.VISIT_OCCURRENCE_ID IS NULL AND p.VISIT_OCCURRENCE_ID IS NULL;

AUDIT (
  name observation_37393449_8840_0_low,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37393449 AND unit_concept_id = 8840 AND value_as_number < 50.0;

AUDIT (
  name observation_37393449_8840_0_high,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37393449 AND unit_concept_id = 8840 AND value_as_number > 500.0;

AUDIT (
  name observation_37393449_8753_0_low,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37393449 AND unit_concept_id = 8753 AND value_as_number < 1.0;

AUDIT (
  name observation_37393449_8753_0_high,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37393449 AND unit_concept_id = 8753 AND value_as_number > 15.0;

AUDIT (
  name observation_37397989_8840_0_low,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37397989 AND unit_concept_id = 8840 AND value_as_number < 50.0;

AUDIT (
  name observation_37397989_8840_0_high,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37397989 AND unit_concept_id = 8840 AND value_as_number > 500.0;

AUDIT (
  name observation_37397989_8753_0_low,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37397989 AND unit_concept_id = 8753 AND value_as_number < 1.0;

AUDIT (
  name observation_37397989_8753_0_high,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37397989 AND unit_concept_id = 8753 AND value_as_number > 15.0;

AUDIT (
  name observation_44809580_8840_0_low,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 44809580 AND unit_concept_id = 8840 AND value_as_number < 50.0;

AUDIT (
  name observation_44809580_8840_0_high,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 44809580 AND unit_concept_id = 8840 AND value_as_number > 500.0;

AUDIT (
  name observation_44809580_8753_0_low,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 44809580 AND unit_concept_id = 8753 AND value_as_number < 1.0;

AUDIT (
  name observation_44809580_8753_0_high,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 44809580 AND unit_concept_id = 8753 AND value_as_number > 15.0;

AUDIT (
  name observation_37392176_8749_0_low,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37392176 AND unit_concept_id = 8749 AND value_as_number < 10.0;

AUDIT (
  name observation_37392176_8749_0_high,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37392176 AND unit_concept_id = 8749 AND value_as_number > 200.0;

AUDIT (
  name observation_37392176_8840_0_low,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37392176 AND unit_concept_id = 8840 AND value_as_number < 0.1;

AUDIT (
  name observation_37392176_8840_0_high,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37392176 AND unit_concept_id = 8840 AND value_as_number > 5.0;

AUDIT (
  name observation_37392176_8751_0_low,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37392176 AND unit_concept_id = 8751 AND value_as_number < 10.0;

AUDIT (
  name observation_37392176_8751_0_high,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.OBSERVATION
WHERE
  OBSERVATION_CONCEPT_ID = 37392176 AND unit_concept_id = 8751 AND value_as_number > 30.0