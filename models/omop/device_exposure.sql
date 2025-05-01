MODEL (
  name omop.device_exposure,
  kind FULL,
  cron '@daily',
  description 'The Device domain captures information about a person’s exposure to a foreign physical object or instrument which is used for diagnostic or therapeutic purposes through a mechanism beyond chemical action.',
  columns (
    device_exposure_id BIGINT,
    person_id BIGINT,
    device_concept_id INT,
    device_exposure_start_date DATE,
    device_exposure_start_datetime TIMESTAMP,
    device_exposure_end_date DATE,
    device_exposure_end_datetime TIMESTAMP,
    device_type_concept_id INT,
    unique_device_id TEXT,
    quantity INT,
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    device_source_value TEXT,
    device_source_concept_id INT,
    unit_source_value TEXT,
    unit_source_concept_id INT
  ),
  column_descriptions (device_exposure_id = 'A unique identifier for each device exposure event.', person_id = 'A foreign key identifier to the Person who is subjected to the Device.', device_concept_id = 'A foreign key to a Standard Concept identifier in the Standardized Vocabularies for the Device.', device_exposure_start_date = 'The date when the Person was first exposed to the Device.', device_exposure_start_datetime = 'The date and time when the Person was first exposed to the Device.', device_exposure_end_date = 'The date when the Person stopped being exposed to the Device.', device_exposure_end_datetime = 'The date and time when the Person stopped being exposed to the Device.', device_type_concept_id = 'A foreign key to a Standard Concept identifier in the Standardized Vocabularies defining the type of source data from which the record originates.', unique_device_id = 'The Unique Device Identifier (UDI) of the Device.', quantity = 'The number of Devices the Person was exposed to.', provider_id = 'A foreign key to the provider in the PROVIDER table who was responsible for the administration of the Device.', visit_occurrence_id = 'A foreign key to the Visit in the VISIT_OCCURRENCE table during which the Device was first used or administered.', visit_detail_id = 'A foreign key to the Visit Detail in the VISIT_DETAIL table during which the Device was first used or administered.', device_source_value = 'The source code for the Device as it appears in the source data.', device_source_concept_id = 'A foreign key to a Concept that refers to the code used in the source.', unit_source_value = 'The source value for the quantity unit.', unit_source_concept_id = 'A foreign key to the concept for the quantity unit.'),
  dialect 'duckdb'
);

/* Note: This assumes a @safe_hash macro exists similar to dbt_utils.generate_surrogate_key */ /* Note: Assumes source columns like stop_datetime and udi exist in stg_synthea__devices */ /* Note: Some columns are cast to NULL based on the dbt model snippet, may need adjustment based on full logic */
SELECT
  ROW_NUMBER() OVER (ORDER BY p.person_id) AS device_exposure_id,
  p.person_id,
  srctostdvm.target_concept_id AS device_concept_id,
  d.device_start_date::DATE AS device_exposure_start_date,
  d.device_start_datetime AS device_exposure_start_datetime,
  d.device_stop_date::DATE AS device_exposure_end_date, /* Assuming stop_datetime exists */
  d.device_stop_datetime AS device_exposure_end_datetime, /* Assuming stop_datetime exists */
  32817 AS device_type_concept_id, /* Defaulting based on common practice, adjust if needed */
  d.udi AS unique_device_id, /* Assuming udi exists */
  NULL::INT AS quantity,
  NULL::BIGINT AS provider_id,
  vd.visit_occurrence_id,
  vd.visit_detail_id,
  d.device_code AS device_source_value,
  srctosrcvm.source_concept_id AS device_source_concept_id,
  NULL::TEXT AS unit_source_value,
  NULL::INT AS unit_source_concept_id
FROM stg.synthea__devices AS d
INNER JOIN int.source_to_standard_vocab_map AS srctostdvm
  ON d.device_code = srctostdvm.source_code
  AND srctostdvm.target_domain_id = 'Device'
  AND srctostdvm.target_vocabulary_id = 'SNOMED'
  AND srctostdvm.source_vocabulary_id = 'SNOMED'
  AND srctostdvm.target_standard_concept = 'S'
  AND srctostdvm.target_invalid_reason IS NULL
INNER JOIN int.source_to_source_vocab_map AS srctosrcvm
  ON d.device_code = srctosrcvm.source_code
  AND srctosrcvm.source_vocabulary_id = 'SNOMED'
INNER JOIN int.person AS p
  ON d.patient_id = p.person_source_value
LEFT JOIN int.visit_detail AS vd
  ON d.encounter_id = vd.encounter_id