MODEL (
    name int.observation_allergies,
    description "Observation data derived from allergies",
    kind FULL,
    columns (
        person_id BIGINT,
        patient_id VARCHAR,
        encounter_id VARCHAR,
        observation_concept_id INT,
        observation_date DATE,
        observation_datetime TIMESTAMP,
        observation_type_concept_id INT,
        provider_id BIGINT,
        visit_occurrence_id BIGINT,
        visit_detail_id BIGINT,
        observation_source_value VARCHAR,
        observation_source_concept_id INT
    )
);

JINJA_QUERY_BEGIN;

SELECT
    p.person_id
    , a.patient_id
    , a.encounter_id
    , srctostdvm.target_concept_id AS observation_concept_id
    , a.allergy_start_date AS observation_date
    , a.allergy_start_date AS observation_datetime -- Assuming start_date can be used as datetime
    , 32827 AS observation_type_concept_id -- Assuming allergy type concept
    , vd.provider_id
    , vd.visit_occurrence_id
    , vd.visit_detail_id
    , a.allergy_code AS observation_source_value
    , srctosrcvm.source_concept_id AS observation_source_concept_id
FROM stg.synthea__allergies AS a
INNER JOIN int.source_to_standard_vocab_map AS srctostdvm
    ON
        a.allergy_code = srctostdvm.source_code
        AND srctostdvm.target_domain_id = 'Observation'
        AND srctostdvm.target_vocabulary_id = 'SNOMED'
        AND srctostdvm.target_standard_concept = 'S'
        AND srctostdvm.target_invalid_reason IS null
INNER JOIN int.source_to_source_vocab_map AS srctosrcvm
    ON
        a.allergy_code = srctosrcvm.source_code
        AND srctosrcvm.source_vocabulary_id = 'SNOMED'
        AND srctosrcvm.source_domain_id = 'Observation'
INNER JOIN int.person AS p
    ON a.patient_id = p.person_source_value
LEFT JOIN int.visit_detail AS vd
    ON a.encounter_id = vd.encounter_id

JINJA_END;
