MODEL (
  name omop.condition_occurrence,
  kind FULL,
  description "Condition Occurrences are records of a Person suggesting the presence of a disease or medical condition stated as a diagnosis, a sign, or a symptom, which is recorded in structured data.",
  columns (
    condition_occurrence_id BIGINT,
    person_id BIGINT,
    condition_concept_id INT,
    condition_start_date DATE,
    condition_start_datetime TIMESTAMP,
    condition_end_date DATE,
    condition_end_datetime TIMESTAMP,
    condition_type_concept_id INT,
    condition_status_concept_id INT,
    stop_reason TEXT,
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    condition_source_value TEXT,
    condition_source_concept_id INT,
    condition_status_source_value TEXT
  ),
  column_descriptions (condition_occurrence_id = 'A unique identifier for each condition occurrence.', person_id = 'A foreign key identifier to the Person who is experiencing the condition.', condition_concept_id = 'A foreign key identifier to the Standard Condition Concept for the condition.', condition_start_date = 'The date when the condition is first recorded.', condition_start_datetime = 'The date and time when the condition is first recorded.', condition_end_date = 'The date when the condition resolved or is assumed to have ended.', condition_end_datetime = 'The date and time when the condition resolved or is assumed to have ended.', condition_type_concept_id = 'A foreign key identifier to the Concept defining the type of condition occurrence.', condition_status_concept_id = 'A foreign key identifier to the Concept defining the status of the condition.', stop_reason = 'The reason the condition was indicated as ended.', provider_id = 'A foreign key identifier to the Provider involved in the diagnosis.', visit_occurrence_id = 'A foreign key identifier to the Visit Occurrence during which the condition was recorded.', visit_detail_id = 'A foreign key identifier to the Visit Detail during which the condition was recorded.', condition_source_value = 'The source code for the condition as it appears in the source data.', condition_source_concept_id = 'A foreign key identifier to a Condition Concept that refers to the code used in the source.', condition_status_source_value = 'The source code for the condition status as it appears in the source data.')
);

SELECT
  ROW_NUMBER() OVER (ORDER BY p.person_id)::BIGINT AS condition_occurrence_id,
  p.person_id::BIGINT,
  srctostdvm.target_concept_id::INT AS condition_concept_id,
  c.condition_start_date::DATE,
  NULL::TIMESTAMP AS condition_start_datetime, /* DBT model casts NULL */
  c.condition_stop_date::DATE AS condition_end_date,
  NULL::TIMESTAMP AS condition_end_datetime, /* DBT model casts NULL */
  32827::INT AS condition_type_concept_id, /* Hardcoded in DBT model */
  0::INT AS condition_status_concept_id, /* Hardcoded in DBT model */
  NULL::TEXT AS stop_reason, /* DBT model casts NULL to varchar */
  vd.provider_id::BIGINT,
  vd.visit_occurrence_id::BIGINT,
  vd.visit_detail_id::BIGINT,
  c.condition_code::TEXT AS condition_source_value,
  srctosrcvm.source_concept_id::INT AS condition_source_concept_id,
  NULL::TEXT AS condition_status_source_value /* DBT model casts NULL to varchar */
FROM stg.synthea__conditions AS c
INNER JOIN int.source_to_standard_vocab_map AS srctostdvm
  ON c.condition_code = srctostdvm.source_code
  AND srctostdvm.target_domain_id = 'Condition'
  AND srctostdvm.target_vocabulary_id = 'SNOMED'
  AND srctostdvm.source_vocabulary_id = 'SNOMED'
  AND srctostdvm.target_standard_concept = 'S'
  AND srctostdvm.target_invalid_reason IS NULL
INNER JOIN int.source_to_source_vocab_map AS srctosrcvm
  ON c.condition_code = srctosrcvm.source_code
  AND srctosrcvm.source_vocabulary_id = 'SNOMED'
  AND srctosrcvm.source_domain_id = 'Condition'
LEFT JOIN int.visit_detail AS vd
  ON c.encounter_id = vd.encounter_id
INNER JOIN int.person AS p
  ON c.patient_id = p.person_source_value