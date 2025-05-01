MODEL (
  name stg.synthea__encounters,
  description "Synthea encounters table",
  kind VIEW,
  columns (
    encounter_id TEXT,
    encounter_start_datetime TIMESTAMP,
    encounter_start_date DATE,
    encounter_stop_datetime TIMESTAMP,
    encounter_stop_date DATE,
    patient_id TEXT,
    organization_id TEXT,
    provider_id TEXT,
    payer_id TEXT,
    encounter_class TEXT,
    encounter_code TEXT,
    encounter_description TEXT,
    base_encounter_cost DOUBLE,
    total_encounter_cost DOUBLE,
    encounter_payer_coverage DOUBLE,
    encounter_reason_code TEXT,
    encounter_reason_description TEXT
  ),
  column_descriptions (encounter_id = 'Unique identifier for the encounter.', encounter_start_datetime = 'The start date and time of the encounter.', encounter_start_date = 'The start date of the encounter.', encounter_stop_datetime = 'The stop date and time of the encounter.', encounter_stop_date = 'The stop date of the encounter.', patient_id = 'The patient ID.', organization_id = 'The organization ID.', provider_id = 'The provider ID.', payer_id = 'The payer ID.', encounter_class = 'The class of the encounter, such as ambulatory, emergency, inpatient, wellness, or urgentcare.', encounter_code = 'The encounter code.', encounter_description = 'The encounter description.', base_encounter_cost = 'The base cost of the encounter.', total_encounter_cost = 'The total cost of the encounter.', encounter_payer_coverage = 'The amount of cost covered by the payer.', encounter_reason_code = 'Diagnosis code from SNOMED-CT, only if this encounter targeted a specific condition.', encounter_reason_description = 'Description of the reason code.')
);

SELECT
  ID AS encounter_id,
  START AS encounter_start_datetime,
  START::DATE AS encounter_start_date,
  COALESCE(STOP, START) AS encounter_stop_datetime, /* Use COALESCE like in dbt model */
  COALESCE(STOP::DATE, START::DATE) AS encounter_stop_date,
  PATIENT AS patient_id,
  ORGANIZATION AS organization_id,
  PROVIDER AS provider_id,
  PAYER AS payer_id,
  ENCOUNTERCLASS AS encounter_class,
  CODE AS encounter_code,
  DESCRIPTION AS encounter_description,
  BASE_ENCOUNTER_COST AS base_encounter_cost,
  TOTAL_CLAIM_COST AS total_encounter_cost, /* Renamed from total_claim_cost */
  PAYER_COVERAGE AS encounter_payer_coverage, /* Renamed from payer_coverage */
  REASONCODE AS encounter_reason_code,
  REASONDESCRIPTION AS encounter_reason_description
FROM synthea.encounters