MODEL (
  name stg.synthea__conditions,
  description "Synthea conditions table",
  kind VIEW,
  columns (
    condition_start_date DATE,
    condition_stop_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    condition_code TEXT,
    condition_description TEXT
  ),
  column_descriptions (condition_start_date = 'The date the condition started.', condition_stop_date = 'The date the condition ended, if applicable.', patient_id = 'The patient ID.', encounter_id = 'The encounter ID.', condition_code = 'The condition code.', condition_description = 'The condition description.')
);

SELECT
  START AS condition_start_date,
  STOP AS condition_stop_date,
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  CODE AS condition_code,
  DESCRIPTION AS condition_description
FROM synthea.conditions