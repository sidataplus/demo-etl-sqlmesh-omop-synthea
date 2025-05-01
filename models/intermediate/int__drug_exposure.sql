MODEL (
  name int.drug_exposure,
  description "Combined drug exposure data from medications and immunizations",
  kind FULL,
  columns (
    drug_exposure_id BIGINT,
    drug_base_cost DECIMAL(18, 3),
    drug_paid_by_payer DECIMAL(18, 3),
    person_id BIGINT,
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
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    drug_source_value TEXT,
    drug_source_concept_id INT,
    route_source_value TEXT,
    dose_unit_source_value TEXT
  )
);

JINJA_QUERY_BEGIN;
WITH all_drugs AS (
    SELECT * FROM int.drug_medications
    UNION ALL
    SELECT * FROM int.drug_immunisations
)

SELECT
    row_number() OVER (ORDER BY person_id, drug_concept_id, drug_exposure_start_datetime) AS drug_exposure_id
    , drug_base_cost
    , drug_paid_by_payer
    , person_id
    , drug_concept_id
    , drug_exposure_start_date
    , drug_exposure_start_datetime
    , drug_exposure_end_date
    , drug_exposure_end_datetime
    , verbatim_end_date
    , drug_type_concept_id
    , stop_reason
    , refills
    , quantity
    , days_supply
    , sig
    , route_concept_id
    , lot_number
    , provider_id
    , visit_occurrence_id
    , visit_detail_id
    , drug_source_value
    , drug_source_concept_id
    , route_source_value
    , dose_unit_source_value
FROM
    all_drugs
JINJA_END;