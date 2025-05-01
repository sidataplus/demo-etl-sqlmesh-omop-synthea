MODEL (
  name int.measurement_procedures,
  description "Measurement data derived from procedures",
  kind FULL,
  columns (
    person_id BIGINT,
    measurement_concept_id INT,
    measurement_date DATE,
    measurement_datetime TIMESTAMP,
    measurement_time TIME,
    measurement_type_concept_id INT,
    operator_concept_id INT,
    value_as_number DECIMAL(18, 3),
    value_as_concept_id INT,
    unit_concept_id INT,
    range_low DECIMAL(18, 3),
    range_high DECIMAL(18, 3),
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    measurement_source_value TEXT,
    measurement_source_concept_id INT,
    unit_source_value TEXT,
    value_source_value TEXT,
    unit_source_concept_id INT,
    measurement_event_id BIGINT,
    meas_event_field_concept_id INT
  )
);

JINJA_QUERY_BEGIN;
SELECT
    p.person_id
    , srctostdvm.target_concept_id AS measurement_concept_id
    , pr.procedure_start_date AS measurement_date
    , pr.procedure_start_datetime AS measurement_datetime
    , CAST(pr.procedure_start_datetime AS TIME) AS measurement_time
    , 32827 AS measurement_type_concept_id
    , 0 AS operator_concept_id
    , CAST(null AS DECIMAL) AS value_as_number
    , 0 AS value_as_concept_id
    , 0 AS unit_concept_id
    , CAST(null AS DECIMAL) AS range_low
    , CAST(null AS DECIMAL) AS range_high
    , vd.provider_id
    , vd.visit_occurrence_id
    , vd.visit_detail_id
    , pr.procedure_code AS measurement_source_value
    , srctosrcvm.source_concept_id AS measurement_source_concept_id
    , CAST(null AS VARCHAR) AS unit_source_value
    , CAST(null AS VARCHAR) AS value_source_value
    , CAST(null AS INT) AS unit_source_concept_id
    , CAST(null AS BIGINT) AS measurement_event_id
    , CAST(null AS INT) AS meas_event_field_concept_id
FROM stg.synthea__procedures AS pr
INNER JOIN int.source_to_standard_vocab_map AS srctostdvm
    ON
        pr.procedure_code = srctostdvm.source_code
        AND srctostdvm.target_domain_id = 'Measurement'
        AND srctostdvm.source_vocabulary_id = 'SNOMED'
        AND srctostdvm.target_standard_concept = 'S'
        AND srctostdvm.target_invalid_reason IS null
INNER JOIN int.source_to_source_vocab_map AS srctosrcvm
    ON
        pr.procedure_code = srctosrcvm.source_code
        AND srctosrcvm.source_vocabulary_id = 'SNOMED'
INNER JOIN int.person AS p
    ON pr.patient_id = p.person_source_value
LEFT JOIN int.visit_detail AS vd
    ON pr.encounter_id = vd.encounter_id
JINJA_END;