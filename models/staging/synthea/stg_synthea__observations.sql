MODEL (
  name stg.synthea__observations,
  description "Synthea observations table",
  kind VIEW,
  columns (
    observation_datetime TIMESTAMP,
    observation_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    observation_category TEXT,
    observation_code TEXT,
    observation_description TEXT,
    observation_value TEXT,
    observation_units TEXT,
    observation_value_type TEXT
  ),
  column_descriptions (
    observation_datetime = 'The date and time of the observation.',
    observation_date = 'The date of the observation.',
    patient_id = 'The patient ID.',
    encounter_id = 'The encounter ID.',
    observation_category = 'The category of the observation.',
    observation_code = 'The observation code.',
    observation_description = 'The observation description.',
    observation_value = 'The value of the observation.',
    observation_units = 'The units of the observation value.',
    observation_value_type = 'The datatype of Value: text or numeric.'
  )
);

SELECT
  DATE AS observation_datetime,
  DATE::DATE AS observation_date,
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  CATEGORY AS observation_category,
  CODE AS observation_code,
  DESCRIPTION AS observation_description,
  VALUE AS observation_value,
  UNITS AS observation_units,
  TYPE AS observation_value_type
FROM synthea.observations