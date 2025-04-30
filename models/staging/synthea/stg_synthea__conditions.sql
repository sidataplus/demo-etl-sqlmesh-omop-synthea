MODEL (
    name stg.synthea__conditions,
    description "Synthea conditions table",
    kind VIEW,
    columns (
        condition_start_date date,
        condition_stop_date date,
        patient_id varchar,
        encounter_id varchar,
        condition_code varchar,
        condition_description varchar
    ),
    column_descriptions (
        condition_start_date = 'The date the condition started.',
        condition_stop_date = 'The date the condition ended, if applicable.',
        patient_id = 'The patient ID.',
        encounter_id = 'The encounter ID.',
        condition_code = 'The condition code.',
        condition_description = 'The condition description.'
    )
);

SELECT
    START as condition_start_date,
    STOP as condition_stop_date,
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    CODE as condition_code,
    DESCRIPTION as condition_description
FROM synthea.conditions;
