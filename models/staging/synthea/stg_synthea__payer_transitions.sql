MODEL (
  name stg.synthea__payer_transitions,
  description "Synthea payer transitions table",
  kind VIEW,
  columns (
    patient_id TEXT,
    member_id TEXT,
    coverage_start_datetime TIMESTAMP,
    coverage_start_date DATE,
    coverage_end_datetime TIMESTAMP,
    coverage_end_date DATE,
    payer_id TEXT,
    secondary_payer_id TEXT,
    plan_owner_relationship TEXT,
    plan_owner_name TEXT
  ),
  column_descriptions (patient_id = 'The patient ID.', member_id = 'Member ID.', coverage_start_datetime = 'The start date and time of the coverage.', coverage_start_date = 'The start date of the coverage.', coverage_end_datetime = 'The end date and time of the coverage.', coverage_end_date = 'The end date of the coverage.', payer_id = 'The primary payer ID.', secondary_payer_id = 'The secondary payer ID.', plan_owner_relationship = 'The owner of the insurance policy. Legal values: Guardian, Self, Spouse.', plan_owner_name = 'The name of the insurance policy owner.')
);

SELECT
  PATIENT AS patient_id,
  MEMBERID AS member_id,
  START_YEAR AS coverage_start_datetime, /* Assuming START_YEAR is timestamp */
  START_YEAR::DATE AS coverage_start_date,
  END_YEAR AS coverage_end_datetime, /* Assuming END_YEAR is timestamp */
  END_YEAR::DATE AS coverage_end_date,
  PAYER AS payer_id,
  SECONDARY_PAYER AS secondary_payer_id,
  OWNERSHIP AS plan_owner_relationship,
  OWNERNAME AS plan_owner_name
FROM synthea.payer_transitions