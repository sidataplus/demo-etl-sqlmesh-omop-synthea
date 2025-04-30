MODEL (
    name int.drug_medications,
    description "Drug exposure data derived from medications",
    kind FULL,
    columns (
        person_id BIGINT,
        patient_id VARCHAR,
        encounter_id VARCHAR,
        provider_id BIGINT,
        visit_occurrence_id BIGINT,
        visit_detail_id BIGINT,
        drug_concept_id INT,
        drug_exposure_start_date DATE,
        drug_exposure_start_datetime TIMESTAMP,
        drug_exposure_end_date DATE,
        drug_exposure_end_datetime TIMESTAMP,
        verbatim_end_date DATE,
        drug_type_concept_id INT,
        stop_reason VARCHAR,
        refills INT,
        quantity INT,
        days_supply INT,
        sig VARCHAR,
        route_concept_id INT,
        lot_number VARCHAR,
        drug_source_value VARCHAR,
        drug_source_concept_id INT,
        route_source_value VARCHAR,
        dose_unit_source_value VARCHAR,
        drug_base_cost NUMERIC,
        drug_paid_by_payer NUMERIC
    )
);

JINJA_QUERY_BEGIN;

SELECT
    p.person_id
    , m.patient_id
    , m.encounter_id
    , vd.provider_id
    , vd.visit_occurrence_id
    , vd.visit_detail_id
    , srctostdvm.target_concept_id AS drug_concept_id
    , m.medication_start_date AS drug_exposure_start_date
    , m.medication_start_datetime AS drug_exposure_start_datetime
    , coalesce(m.medication_stop_date, m.medication_start_date) AS drug_exposure_end_date
    , coalesce(m.medication_stop_datetime, m.medication_start_datetime) AS drug_exposure_end_datetime
    , m.medication_stop_date AS verbatim_end_date
    , 32838 AS drug_type_concept_id
    , CAST(null AS VARCHAR) AS stop_reason
    , CAST(null AS INT) AS refills
    , CAST(null AS INT) AS quantity
    , m.medication_stop_date - m.medication_start_date AS days_supply
    , CAST(null AS VARCHAR) AS sig
    , 0 AS route_concept_id
    , '0' AS lot_number
    , m.medication_code AS drug_source_value
    , srctosrcvm.source_concept_id AS drug_source_concept_id
    , CAST(null AS VARCHAR) AS route_source_value
    , CAST(null AS VARCHAR) AS dose_unit_source_value
    , m.medication_base_cost AS drug_base_cost
    , m.medication_payer_coverage AS drug_paid_by_payer
FROM stg.synthea__medications AS m
INNER JOIN int.source_to_standard_vocab_map AS srctostdvm
    ON
        m.medication_code = srctostdvm.source_code
        AND srctostdvm.target_domain_id = 'Drug'
        AND srctostdvm.target_vocabulary_id = 'RxNorm'
        AND srctostdvm.target_standard_concept = 'S'
        AND srctostdvm.target_invalid_reason IS null
INNER JOIN int.source_to_source_vocab_map AS srctosrcvm
    ON
        m.medication_code = srctosrcvm.source_code
        AND srctosrcvm.source_vocabulary_id = 'RxNorm'
INNER JOIN int.person AS p
    ON m.patient_id = p.person_source_value
LEFT JOIN int.visit_detail AS vd
    ON m.encounter_id = vd.encounter_id

JINJA_END;
