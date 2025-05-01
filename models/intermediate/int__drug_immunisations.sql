MODEL (
  name int.drug_immunisations,
  description "Drug exposure data derived from immunizations",
  kind FULL,
  columns (
    person_id BIGINT,
    patient_id TEXT,
    encounter_id TEXT,
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
    stop_reason TEXT,
    refills INT,
    quantity INT,
    days_supply INT,
    sig TEXT,
    route_concept_id INT,
    lot_number TEXT,
    drug_source_value TEXT,
    drug_source_concept_id INT,
    route_source_value TEXT,
    dose_unit_source_value TEXT,
    drug_base_cost DECIMAL(18, 3),
    drug_paid_by_payer DECIMAL(18, 3)
  )
);

JINJA_QUERY_BEGIN;
SELECT
    p.person_id
    , i.patient_id
    , i.encounter_id
    , vd.provider_id
    , vd.visit_occurrence_id
    , vd.visit_detail_id
    , srctostdvm.target_concept_id AS drug_concept_id
    , CAST(i.immunization_date AS DATE) AS drug_exposure_start_date
    , i.immunization_date AS drug_exposure_start_datetime
    , CAST(i.immunization_date AS DATE) AS drug_exposure_end_date
    , i.immunization_date AS drug_exposure_end_datetime
    , CAST(i.immunization_date AS DATE) AS verbatim_end_date
    , 32827 AS drug_type_concept_id
    , CAST(null AS VARCHAR) AS stop_reason
    , CAST(null AS INT) AS refills
    , CAST(null AS INT) AS quantity
    , CAST(null AS INT) AS days_supply
    , CAST(null AS VARCHAR) AS sig
    , 0 AS route_concept_id
    , '0' AS lot_number
    , i.immunization_code AS drug_source_value
    , srctosrcvm.source_concept_id AS drug_source_concept_id
    , CAST(null AS VARCHAR) AS route_source_value
    , CAST(null AS VARCHAR) AS dose_unit_source_value
    , i.immunization_base_cost AS drug_base_cost
    , CAST(null AS NUMERIC) AS drug_paid_by_payer
FROM stg.synthea__immunizations AS i
INNER JOIN int.source_to_standard_vocab_map AS srctostdvm
    ON
        i.immunization_code = srctostdvm.source_code
        AND srctostdvm.target_domain_id = 'Drug'
        AND srctostdvm.target_vocabulary_id = 'CVX'
        AND srctostdvm.target_standard_concept = 'S'
        AND srctostdvm.target_invalid_reason IS null
INNER JOIN int.source_to_source_vocab_map AS srctosrcvm
    ON
        i.immunization_code = srctosrcvm.source_code
        AND srctosrcvm.source_vocabulary_id = 'CVX'
INNER JOIN int.person AS p
    ON i.patient_id = p.person_source_value
LEFT JOIN int.visit_detail AS vd
    ON i.encounter_id = vd.encounter_id
JINJA_END;