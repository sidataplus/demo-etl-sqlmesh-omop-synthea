MODEL (
    name stg.synthea__immunizations,
    description "Synthea immunizations table",
    kind VIEW,
    columns (
        immunization_date date,
        patient_id varchar,
        encounter_id varchar,
        immunization_code varchar,
        immunization_description varchar,
        immunization_base_cost double
    ),
    column_descriptions (
        immunization_date = 'The date of the immunization.',
        patient_id = 'The patient ID.',
        encounter_id = 'The encounter ID.',
        immunization_code = 'The immunization code.',
        immunization_description = 'The immunization description.',
        immunization_base_cost = 'The line item cost of the immunization.'
    )
);

SELECT
    DATE as immunization_date,
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    CODE as immunization_code,
    DESCRIPTION as immunization_description,
    BASE_COST as immunization_base_cost
FROM synthea.immunizations;
