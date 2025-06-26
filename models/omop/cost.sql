MODEL (
  name omop.cost,
  description 'The COST table captures records containing the cost of any medical event recorded in one of the OMOP clinical event tables.',
  kind FULL,
  columns (
    cost_id BIGINT,
    cost_event_id BIGINT,
    cost_domain_id TEXT,
    cost_type_concept_id INT,
    currency_concept_id INT,
    total_charge DECIMAL(18, 3),
    total_cost DECIMAL(18, 3),
    total_paid DECIMAL(18, 3),
    paid_by_payer DECIMAL(18, 3),
    paid_by_patient DECIMAL(18, 3),
    paid_patient_copay DECIMAL(18, 3),
    paid_patient_coinsurance DECIMAL(18, 3),
    paid_patient_deductible DECIMAL(18, 3),
    paid_by_primary DECIMAL(18, 3),
    paid_ingredient_cost DECIMAL(18, 3),
    paid_dispensing_fee DECIMAL(18, 3),
    payer_plan_period_id BIGINT,
    amount_allowed DECIMAL(18, 3),
    revenue_code_concept_id INT,
    revenue_code_source_value TEXT,
    drg_concept_id INT,
    drg_source_value TEXT
  ),
  audits (
    cost_cost_domain_id_is_required,
    cost_cost_domain_id_is_foreign_key,
    cost_cost_event_id_is_required,
    cost_cost_id_is_required,
    cost_cost_id_is_primary_key,
    cost_cost_type_concept_id_is_required,
    cost_cost_type_concept_id_is_foreign_key,
    cost_cost_type_concept_id_is_standard_valid_concept,
    cost_cost_type_concept_id_standard_concept_record_completeness,
    cost_currency_concept_id_is_foreign_key,
    cost_drg_concept_id_is_foreign_key,
    cost_revenue_code_concept_id_is_foreign_key
  )
);

WITH all_costs AS (
    /* Costs from drug exposures */
    SELECT
      drug_exposure_id AS cost_event_id,
      'Drug' AS cost_domain_id,
      drug_base_cost AS total_cost,
      drug_paid_by_payer AS paid_by_payer
    FROM int.drug_exposure
    UNION ALL
    /* Costs from procedure occurrences */
    SELECT
      procedure_occurrence_id AS cost_event_id,
      'Procedure' AS cost_domain_id,
      procedure_base_cost AS total_cost,
      NULL::DECIMAL(18, 3) AS paid_by_payer
    FROM int.procedure_occurrence
    UNION ALL
    /* Costs from visit details */
    SELECT
      visit_detail_id AS cost_event_id,
      'Visit' AS cost_domain_id,
      total_encounter_cost AS total_cost,
      encounter_payer_coverage AS paid_by_payer
    FROM int.visit_detail
)
SELECT
  ROW_NUMBER() OVER (ORDER BY cost_domain_id, cost_event_id) AS cost_id,
  cost_event_id,
  cost_domain_id,
  32814 AS cost_type_concept_id, /* Payer Reimbursed Cost */
  44818668 AS currency_concept_id, /* USD */
  NULL::DECIMAL(18, 3) AS total_charge,
  total_cost,
  NULL::DECIMAL(18, 3) AS total_paid,
  paid_by_payer,
  NULL::DECIMAL(18, 3) AS paid_by_patient,
  NULL::DECIMAL(18, 3) AS paid_patient_copay,
  NULL::DECIMAL(18, 3) AS paid_patient_coinsurance,
  NULL::DECIMAL(18, 3) AS paid_patient_deductible,
  NULL::DECIMAL(18, 3) AS paid_by_primary,
  NULL::DECIMAL(18, 3) AS paid_ingredient_cost,
  NULL::DECIMAL(18, 3) AS paid_dispensing_fee,
  NULL::INT AS payer_plan_period_id,
  NULL::DECIMAL(18, 3) AS amount_allowed,
  NULL::INT AS revenue_code_concept_id,
  NULL::TEXT AS revenue_code_source_value,
  NULL::INT AS drg_concept_id,
  NULL::TEXT AS drg_source_value
FROM all_costs