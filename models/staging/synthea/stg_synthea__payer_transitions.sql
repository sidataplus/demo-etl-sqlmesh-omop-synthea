MODEL (
    name stg.synthea__payer_transitions,
    description "Synthea payer transitions table",
    kind VIEW,
    columns (
        patient_id varchar,
        member_id varchar,
        coverage_start_datetime timestamp,
        coverage_start_date date,
        coverage_end_datetime timestamp,
        coverage_end_date date,
        payer_id varchar,
        secondary_payer_id varchar,
        plan_owner_relationship varchar,
        plan_owner_name varchar
    ),
    column_descriptions (
        patient_id = 'The patient ID.',
        member_id = 'Member ID.',
        coverage_start_datetime = 'The start date and time of the coverage.',
        coverage_start_date = 'The start date of the coverage.',
        coverage_end_datetime = 'The end date and time of the coverage.',
        coverage_end_date = 'The end date of the coverage.',
        payer_id = 'The primary payer ID.',
        secondary_payer_id = 'The secondary payer ID.',
        plan_owner_relationship = 'The owner of the insurance policy. Legal values: Guardian, Self, Spouse.',
        plan_owner_name = 'The name of the insurance policy owner.'
    )
);

SELECT
    PATIENT as patient_id,
    MEMBERID as member_id,
    START_YEAR as coverage_start_datetime, -- Assuming START_YEAR is timestamp
    CAST(START_YEAR as date) as coverage_start_date,
    END_YEAR as coverage_end_datetime, -- Assuming END_YEAR is timestamp
    CAST(END_YEAR as date) as coverage_end_date,
    PAYER as payer_id,
    SECONDARY_PAYER as secondary_payer_id,
    OWNERSHIP as plan_owner_relationship,
    OWNERNAME as plan_owner_name
FROM synthea.payer_transitions;
