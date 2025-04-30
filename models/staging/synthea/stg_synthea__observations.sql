MODEL (
    name stg.synthea__observations,
    description "Synthea observations table",
    kind VIEW,
    columns (
        observation_datetime timestamp,
        observation_date date,
        patient_id varchar,
        encounter_id varchar,
        observation_category varchar,
        observation_code varchar,
        observation_description varchar,
        observation_value varchar,
        observation_units varchar,
        observation_value_type varchar
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
    DATE as observation_datetime,
    CAST(DATE as date) as observation_date,
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    CATEGORY as observation_category,
    CODE as observation_code,
    DESCRIPTION as observation_description,
    VALUE as observation_value,
    UNITS as observation_units,
    TYPE as observation_value_type
FROM synthea.observations;
