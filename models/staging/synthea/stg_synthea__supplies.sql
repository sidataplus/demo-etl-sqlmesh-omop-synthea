MODEL (
    name stg.synthea__supplies,
    description "Synthea supplies table",
    kind VIEW,
    columns (
        supply_date date,
        patient_id varchar,
        encounter_id varchar,
        supply_code varchar,
        supply_description varchar,
        supply_quantity int
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
    DATE as supply_date,
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    CODE as supply_code,
    DESCRIPTION as supply_description,
    QUANTITY as supply_quantity
FROM synthea.supplies;
