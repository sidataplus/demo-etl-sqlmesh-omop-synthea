MODEL (
  name stg.synthea__supplies,
  description "Synthea supplies table",
  kind VIEW,
  columns (
    supply_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    supply_code TEXT,
    supply_description TEXT,
    supply_quantity INT
  ),
  column_descriptions (
    supply_date = 'The date the supply was provided.',
    patient_id = 'The patient ID.',
    encounter_id = 'The encounter ID.',
    supply_code = 'The supply code.',
    supply_description = 'The supply description.',
    supply_quantity = 'The quantity of the supply.'
  )
);

SELECT
  DATE AS supply_date,
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  CODE AS supply_code,
  DESCRIPTION AS supply_description,
  QUANTITY AS supply_quantity
FROM synthea.supplies