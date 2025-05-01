MODEL (
  name stg.synthea__medications,
  description "Synthea medications table",
  kind VIEW,
  columns (
    medication_start_datetime TIMESTAMP,
    medication_start_date DATE,
    medication_stop_datetime TIMESTAMP,
    medication_stop_date DATE,
    patient_id TEXT,
    payer_id TEXT,
    encounter_id TEXT,
    medication_code TEXT,
    medication_description TEXT,
    medication_base_cost DOUBLE,
    medication_payer_coverage DOUBLE,
    dispenses INT,
    medication_total_cost DOUBLE,
    medication_reason_code TEXT,
    medication_reason_description TEXT
  ),
  column_descriptions (medication_start_datetime = 'The start date and time of the medication.', medication_start_date = 'The start date of the medication.', medication_stop_datetime = 'The stop date and time of the medication.', medication_stop_date = 'The stop date of the medication.', patient_id = 'The patient ID.', payer_id = 'The payer ID.', encounter_id = 'The encounter ID.', medication_code = 'The medication code.', medication_description = 'The medication description.', medication_base_cost = 'The line item cost of the medication.', medication_payer_coverage = 'The amount of cost covered by the payer.', dispenses = 'The number of times the prescription was filled.', medication_total_cost = 'The total cost of the prescription, including all dispenses.', medication_reason_code = 'Diagnosis code from SNOMED-CT specifying why this medication was prescribed.', medication_reason_description = 'Description of the reason code.')
);

SELECT
  START AS medication_start_datetime,
  START::DATE AS medication_start_date,
  STOP AS medication_stop_datetime,
  STOP::DATE AS medication_stop_date,
  PATIENT AS patient_id,
  PAYER AS payer_id,
  ENCOUNTER AS encounter_id,
  CODE AS medication_code,
  DESCRIPTION AS medication_description,
  BASE_COST AS medication_base_cost,
  PAYER_COVERAGE AS medication_payer_coverage,
  DISPENSES AS dispenses,
  TOTALCOST AS medication_total_cost,
  REASONCODE AS medication_reason_code,
  REASONDESCRIPTION AS medication_reason_description
FROM synthea.medications