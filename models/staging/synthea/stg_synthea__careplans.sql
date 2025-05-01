MODEL (
  name stg.synthea__careplans,
  description "Synthea careplans table",
  kind VIEW,
  columns (
    careplan_id TEXT,
    careplan_start_date DATE,
    careplan_stop_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    careplan_code TEXT,
    careplan_description TEXT,
    careplan_reason_code TEXT,
    careplan_reason_description TEXT
  ),
  column_descriptions (careplan_id = 'Unique identifier for the careplan.', careplan_start_date = 'The date the careplan was initiated.', careplan_stop_date = 'The date the careplan ended, if applicable.', patient_id = 'The patient ID.', encounter_id = 'The encounter ID.', careplan_code = 'The careplan code.', careplan_description = 'The careplan description.', careplan_reason_code = 'Diagnosis code from SNOMED-CT that this care plan addresses.', careplan_reason_description = 'Description of the reason code.')
);

SELECT
  ID AS careplan_id,
  START AS careplan_start_date,
  STOP AS careplan_stop_date,
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  CODE AS careplan_code,
  DESCRIPTION AS careplan_description,
  REASONCODE AS careplan_reason_code,
  REASONDESCRIPTION AS careplan_reason_description
FROM synthea.careplans