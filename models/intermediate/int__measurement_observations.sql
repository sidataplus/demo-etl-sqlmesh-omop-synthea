MODEL (
  name int.measurement_observations,
  description "Measurement data derived from observations",
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
    , o.observation_date AS measurement_date
    , o.observation_datetime AS measurement_datetime
    , CAST(o.observation_datetime AS TIME) AS measurement_time
    , 32827 AS measurement_type_concept_id
    , 0 AS operator_concept_id
    , CASE
        WHEN REGEXP_MATCHES(o.observation_value, '^[-+]?[0-9]+\.?[0-9]*$')
            THEN CAST(o.observation_value AS DECIMAL)
        ELSE CAST(null AS DECIMAL)
    END AS value_as_number
    , coalesce(srcmap2.target_concept_id, 0) AS value_as_concept_id
    , coalesce(srcmap1.target_concept_id, 0) AS unit_concept_id
    , CAST(null AS DECIMAL) AS range_low
    , CAST(null AS DECIMAL) AS range_high
    , vd.provider_id
    , vd.visit_occurrence_id
    , vd.visit_detail_id
    , o.observation_code AS measurement_source_value
    , coalesce(
        srctosrcvm.source_concept_id, 0
    ) AS measurement_source_concept_id
    , o.observation_units AS unit_source_value
    , o.observation_value AS value_source_value
    , CAST(null AS INT) AS unit_source_concept_id
    , CAST(null AS BIGINT) AS measurement_event_id
    , CAST(null AS INT) AS meas_event_field_concept_id
FROM stg.synthea__observations AS o
INNER JOIN int.source_to_standard_vocab_map AS srctostdvm
    ON
        o.observation_code = srctostdvm.source_code
        AND srctostdvm.target_domain_id = 'Measurement'
        AND srctostdvm.source_vocabulary_id = 'LOINC'
        AND srctostdvm.target_standard_concept = 'S'
        AND srctostdvm.target_invalid_reason IS null
LEFT JOIN int.source_to_standard_vocab_map AS srcmap1
    ON
        o.observation_units = srcmap1.source_code
        AND srcmap1.target_vocabulary_id = 'UCUM'
        AND srcmap1.source_vocabulary_id = 'UCUM'
        AND srcmap1.target_standard_concept = 'S'
        AND srcmap1.target_invalid_reason IS null
LEFT JOIN int.source_to_standard_vocab_map AS srcmap2
    ON
        o.observation_value = srcmap2.source_code
        AND srcmap2.target_domain_id = 'Meas value'
        AND srcmap2.target_standard_concept = 'S'
        AND srcmap2.target_invalid_reason IS null
LEFT JOIN int.source_to_source_vocab_map AS srctosrcvm
    ON
        o.observation_code = srctosrcvm.source_code
        AND srctosrcvm.source_vocabulary_id = 'LOINC'
INNER JOIN int.person AS p
    ON o.patient_id = p.person_source_value
LEFT JOIN int.visit_detail AS vd
    ON o.encounter_id = vd.encounter_id
JINJA_END;