MODEL (
  name stg.synthea__immunizations,
  description "Synthea immunizations table",
  kind VIEW,
  columns (
    immunization_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    immunization_code TEXT,
    immunization_description TEXT,
    immunization_base_cost DOUBLE
  ),
  column_descriptions (immunization_date = 'The date of the immunization.', patient_id = 'The patient ID.', encounter_id = 'The encounter ID.', immunization_code = 'The immunization code.', immunization_description = 'The immunization description.', immunization_base_cost = 'The line item cost of the immunization.')
);

SELECT
  DATE AS immunization_date,
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  CODE AS immunization_code,
  DESCRIPTION AS immunization_description,
  BASE_COST AS immunization_base_cost
FROM synthea.immunizations