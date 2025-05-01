MODEL (
    name omop.death,
    description 'The death domain contains the clinical event for how and when a Person dies.',
    kind FULL,
    columns (
        person_id BIGINT,
        death_date DATE,
        death_datetime TIMESTAMP,
        death_type_concept_id INT,
        cause_concept_id INT,
        cause_source_value VARCHAR,
        cause_source_concept_id INT
    )
);

-- NB:
-- We observe death records in both the encounters.csv and observations.csv file.
-- To find the death records in observations, use code = '69453-9'. This is a LOINC code
-- that represents an observation of the US standard certificate of death.
-- Encounters.code = '308646001' is the SNOMED observation of death certification.
-- The reasoncode column is the SNOMED code for the condition that caused death.

SELECT
    e.person_id,
    CAST(e.encounter_start_date AS DATE) AS death_date,
    e.encounter_start_datetime AS death_datetime,
    32817 AS death_type_concept_id, -- EHR representation
    srctostdvm.target_concept_id AS cause_concept_id,
    e.encounter_reason_code AS cause_source_value,
    srctostdvm.source_concept_id AS cause_source_concept_id
FROM int.encounters AS e
INNER JOIN int.source_to_standard_vocab_map AS srctostdvm
    ON
        e.encounter_reason_code = srctostdvm.source_code
        AND srctostdvm.target_domain_id = 'Condition'
        AND srctostdvm.source_domain_id = 'Condition'
        AND srctostdvm.target_vocabulary_id = 'SNOMED'
        AND srctostdvm.source_vocabulary_id = 'SNOMED'
        AND srctostdvm.target_standard_concept = 'S'
        AND srctostdvm.target_invalid_reason IS NULL
WHERE e.encounter_code = '308646001'; -- SNOMED code for 'Death certification'
