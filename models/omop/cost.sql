MODEL (
    name omop.cost,
    description 'The COST table captures records containing the cost of any medical event recorded in one of the OMOP clinical event tables.',
    kind FULL,
    columns (
        cost_id BIGINT,
        cost_event_id BIGINT,
        cost_domain_id VARCHAR,
        cost_type_concept_id INT,
        currency_concept_id INT,
        total_charge NUMERIC,
        total_cost NUMERIC,
        total_paid NUMERIC,
        paid_by_payer NUMERIC,
        paid_by_patient NUMERIC,
        paid_patient_copay NUMERIC,
        paid_patient_coinsurance NUMERIC,
        paid_patient_deductible NUMERIC,
        paid_by_primary NUMERIC,
        paid_ingredient_cost NUMERIC,
        paid_dispensing_fee NUMERIC,
        payer_plan_period_id BIGINT,
        amount_allowed NUMERIC,
        revenue_code_concept_id INT,
        revenue_code_source_value VARCHAR,
        drg_concept_id INT,
        drg_source_value VARCHAR
    )
);

WITH all_costs AS (
    -- Costs from drug exposures
    SELECT
        drug_exposure_id AS cost_event_id,
        'Drug' AS cost_domain_id,
        drug_base_cost AS total_cost,
        drug_paid_by_payer AS paid_by_payer,
    FROM int.drug_exposure

    UNION ALL

    -- Costs from procedure occurrences
    SELECT
        procedure_occurrence_id AS cost_event_id,
        'Procedure' AS cost_domain_id,
        procedure_base_cost AS total_cost,
        NULL::NUMERIC AS paid_by_payer,
    FROM int.procedure_occurrence

    UNION ALL

    -- Costs from visit details
    SELECT
        visit_detail_id AS cost_event_id,
        'Visit' AS cost_domain_id,
        total_encounter_cost AS total_cost,
        encounter_payer_coverage AS paid_by_payer,
    FROM int.visit_detail
)
SELECT
    ROW_NUMBER() OVER (ORDER BY cost_domain_id, cost_event_id) AS cost_id,
    cost_event_id,
    cost_domain_id,
    32814 AS cost_type_concept_id, -- Payer Reimbursed Cost
    44818668 AS currency_concept_id, -- USD
    CAST(NULL AS NUMERIC) AS total_charge,
    total_cost,
    CAST(NULL AS NUMERIC) AS total_paid,
    paid_by_payer,
    CAST(NULL AS NUMERIC) AS paid_by_patient,
    CAST(NULL AS NUMERIC) AS paid_patient_copay,
    CAST(NULL AS NUMERIC) AS paid_patient_coinsurance,
    CAST(NULL AS NUMERIC) AS paid_patient_deductible,
    CAST(NULL AS NUMERIC) AS paid_by_primary,
    CAST(NULL AS NUMERIC) AS paid_ingredient_cost,
    CAST(NULL AS NUMERIC) AS paid_dispensing_fee,
    NULL::INTEGER AS payer_plan_period_id,
    CAST(NULL AS NUMERIC) AS amount_allowed,
    CAST(NULL AS INT) AS revenue_code_concept_id,
    NULL::VARCHAR AS revenue_code_source_value,
    CAST(NULL AS INT) AS drg_concept_id,
    NULL::VARCHAR AS drg_source_value
FROM all_costs;
