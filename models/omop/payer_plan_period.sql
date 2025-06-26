MODEL (
  name omop.payer_plan_period,
  kind FULL,
  description "Contains records reflecting the time interval during which a Person is continuously enrolled under a specific Payer Plan.",
  columns (
    payer_plan_period_id BIGINT,
    person_id BIGINT,
    payer_plan_period_start_date DATE,
    payer_plan_period_end_date DATE,
    payer_concept_id INT,
    payer_source_value TEXT,
    payer_source_concept_id INT,
    plan_concept_id INT,
    plan_source_value TEXT,
    plan_source_concept_id INT,
    sponsor_concept_id INT,
    sponsor_source_value TEXT,
    sponsor_source_concept_id INT,
    family_source_value TEXT,
    stop_reason_concept_id INT,
    stop_reason_source_value TEXT,
    stop_reason_source_concept_id INT
  ),
  column_descriptions (
    payer_plan_period_id = 'A unique identifier for each payer plan period.',
    person_id = 'A foreign key identifier to the Person covered by the Plan.',
    payer_plan_period_start_date = 'The start date of the Plan coverage.',
    payer_plan_period_end_date = 'The end date of the Plan coverage.',
    payer_concept_id = 'A foreign key identifier to the Concept representing the Payer.',
    payer_source_value = 'The source value for the Payer.',
    payer_source_concept_id = 'A foreign key identifier to a Concept that refers to the Payer source value.',
    plan_concept_id = 'A foreign key identifier to the Concept representing the specific health benefit Plan.',
    plan_source_value = 'The source value for the Plan.',
    plan_source_concept_id = 'A foreign key identifier to a Concept that refers to the Plan source value.',
    sponsor_concept_id = 'A foreign key identifier to the Concept representing the sponsor of the Plan.',
    sponsor_source_value = 'The source value for the Plan sponsor.',
    sponsor_source_concept_id = 'A foreign key identifier to a Concept that refers to the sponsor source value.',
    family_source_value = 'The common identifier for all people covered by the same policy.',
    stop_reason_concept_id = 'A foreign key identifier to the Concept representing the reason the Person left the Plan.',
    stop_reason_source_value = 'The source value for the stop reason.',
    stop_reason_source_concept_id = 'A foreign key identifier to a Concept that refers to the stop reason source value.'
  ),
  audits (
    person_completeness_payer_plan_period,
    payer_plan_period_payer_concept_id_is_foreign_key,
    payer_plan_period_payer_plan_period_end_date_is_required,
    payer_plan_period_payer_plan_period_end_date_after_birth,
    payer_plan_period_payer_plan_period_id_is_required,
    payer_plan_period_payer_plan_period_id_is_primary_key,
    payer_plan_period_payer_plan_period_start_date_is_required,
    payer_plan_period_payer_plan_period_start_date_start_before_end,
    payer_plan_period_payer_plan_period_start_date_after_birth,
    payer_plan_period_payer_source_concept_id_is_foreign_key,
    payer_plan_period_person_id_is_required,
    payer_plan_period_person_id_is_foreign_key,
    payer_plan_period_plan_concept_id_is_foreign_key,
    payer_plan_period_plan_source_concept_id_is_foreign_key,
    payer_plan_period_sponsor_concept_id_is_foreign_key,
    payer_plan_period_sponsor_source_concept_id_is_foreign_key,
    payer_plan_period_stop_reason_concept_id_is_foreign_key,
    payer_plan_period_stop_reason_source_concept_id_is_foreign_key
  )
);

SELECT
  ROW_NUMBER() OVER (ORDER BY pat.patient_id, pt.coverage_start_datetime) AS payer_plan_period_id,
  per.person_id,
  pt.coverage_start_date AS payer_plan_period_start_date,
  pt.coverage_end_date AS payer_plan_period_end_date,
  0 AS payer_concept_id,
  pt.payer_id AS payer_source_value,
  0 AS payer_source_concept_id,
  0 AS plan_concept_id,
  pay.payer_name AS plan_source_value,
  0 AS plan_source_concept_id,
  0 AS sponsor_concept_id,
  NULL::TEXT AS sponsor_source_value,
  0 AS sponsor_source_concept_id,
  NULL::TEXT AS family_source_value,
  0 AS stop_reason_concept_id,
  NULL::TEXT AS stop_reason_source_value,
  0 AS stop_reason_source_concept_id
FROM stg.synthea__payers AS pay
INNER JOIN stg.synthea__payer_transitions AS pt
  ON pay.payer_id = pt.payer_id
INNER JOIN stg.synthea__patients AS pat
  ON pt.patient_id = pat.patient_id
INNER JOIN omop.person AS per
  ON pat.patient_id = per.person_source_value