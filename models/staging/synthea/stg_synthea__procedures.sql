MODEL (
  name stg.synthea__procedures,
  description "Synthea procedures table",
  kind VIEW,
  columns (
    procedure_start_datetime TIMESTAMP,
    procedure_start_date DATE,
    procedure_stop_datetime TIMESTAMP,
    procedure_stop_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    procedure_code TEXT,
    procedure_description TEXT,
    procedure_base_cost DOUBLE,
    procedure_reason_code TEXT,
    procedure_reason_description TEXT
  ),
  column_descriptions (procedure_start_datetime = 'The start date and time of the procedure.', procedure_start_date = 'The start date of the procedure.', procedure_stop_datetime = 'The stop date and time of the procedure.', procedure_stop_date = 'The stop date of the procedure.', patient_id = 'The patient ID.', encounter_id = 'The encounter ID.', procedure_code = 'The procedure code.', procedure_description = 'The procedure description.', procedure_base_cost = 'The line item cost of the procedure.', procedure_reason_code = 'Diagnosis code from SNOMED-CT specifying why this procedure was performed.', procedure_reason_description = 'Description of the reason code.')
);

SELECT
  START AS procedure_start_datetime,
  START::DATE AS procedure_start_date,
  STOP AS procedure_stop_datetime,
  STOP::DATE AS procedure_stop_date,
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  CODE AS procedure_code,
  DESCRIPTION AS procedure_description,
  BASE_COST AS procedure_base_cost,
  REASONCODE AS procedure_reason_code,
  REASONDESCRIPTION AS procedure_reason_description
FROM synthea.procedures