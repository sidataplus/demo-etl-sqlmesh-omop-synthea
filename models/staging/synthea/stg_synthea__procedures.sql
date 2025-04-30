MODEL (
    name stg.synthea__procedures,
    description "Synthea procedures table",
    kind VIEW,
    columns (
        procedure_start_datetime timestamp,
        procedure_start_date date,
        procedure_stop_datetime timestamp,
        procedure_stop_date date,
        patient_id varchar,
        encounter_id varchar,
        procedure_code varchar,
        procedure_description varchar,
        procedure_base_cost double,
        procedure_reason_code varchar,
        procedure_reason_description varchar
    ),
    column_descriptions (
        procedure_start_datetime = 'The start date and time of the procedure.',
        procedure_start_date = 'The start date of the procedure.',
        procedure_stop_datetime = 'The stop date and time of the procedure.',
        procedure_stop_date = 'The stop date of the procedure.',
        patient_id = 'The patient ID.',
        encounter_id = 'The encounter ID.',
        procedure_code = 'The procedure code.',
        procedure_description = 'The procedure description.',
        procedure_base_cost = 'The line item cost of the procedure.',
        procedure_reason_code = 'Diagnosis code from SNOMED-CT specifying why this procedure was performed.',
        procedure_reason_description = 'Description of the reason code.'
    )
);

SELECT
    START as procedure_start_datetime,
    CAST(START as date) as procedure_start_date,
    STOP as procedure_stop_datetime,
    CAST(STOP as date) as procedure_stop_date,
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    CODE as procedure_code,
    DESCRIPTION as procedure_description,
    BASE_COST as procedure_base_cost,
    REASONCODE as procedure_reason_code,
    REASONDESCRIPTION as procedure_reason_description
FROM synthea.procedures;
