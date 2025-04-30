MODEL (
    name stg.synthea__encounters,
    description "Synthea encounters table",
    kind VIEW,
    columns (
        encounter_id varchar,
        encounter_start_datetime timestamp,
        encounter_start_date date,
        encounter_stop_datetime timestamp,
        encounter_stop_date date,
        patient_id varchar,
        organization_id varchar,
        provider_id varchar,
        payer_id varchar,
        encounter_class varchar,
        encounter_code varchar,
        encounter_description varchar,
        base_encounter_cost double,
        total_encounter_cost double,
        encounter_payer_coverage double,
        encounter_reason_code varchar,
        encounter_reason_description varchar
    ),
    column_descriptions (
        encounter_id = 'Unique identifier for the encounter.',
        encounter_start_datetime = 'The start date and time of the encounter.',
        encounter_start_date = 'The start date of the encounter.',
        encounter_stop_datetime = 'The stop date and time of the encounter.',
        encounter_stop_date = 'The stop date of the encounter.',
        patient_id = 'The patient ID.',
        organization_id = 'The organization ID.',
        provider_id = 'The provider ID.',
        payer_id = 'The payer ID.',
        encounter_class = 'The class of the encounter, such as ambulatory, emergency, inpatient, wellness, or urgentcare.',
        encounter_code = 'The encounter code.',
        encounter_description = 'The encounter description.',
        base_encounter_cost = 'The base cost of the encounter.',
        total_encounter_cost = 'The total cost of the encounter.',
        encounter_payer_coverage = 'The amount of cost covered by the payer.',
        encounter_reason_code = 'Diagnosis code from SNOMED-CT, only if this encounter targeted a specific condition.',
        encounter_reason_description = 'Description of the reason code.'
    )
);

SELECT
    ID as encounter_id,
    START as encounter_start_datetime,
    CAST(START as date) as encounter_start_date,
    COALESCE(STOP, START) as encounter_stop_datetime, -- Use COALESCE like in dbt model
    COALESCE(CAST(STOP as date), CAST(START as date)) as encounter_stop_date,
    PATIENT as patient_id,
    ORGANIZATION as organization_id,
    PROVIDER as provider_id,
    PAYER as payer_id,
    ENCOUNTERCLASS as encounter_class,
    CODE as encounter_code,
    DESCRIPTION as encounter_description,
    BASE_ENCOUNTER_COST as base_encounter_cost,
    TOTAL_CLAIM_COST as total_encounter_cost, -- Renamed from total_claim_cost
    PAYER_COVERAGE as encounter_payer_coverage, -- Renamed from payer_coverage
    REASONCODE as encounter_reason_code,
    REASONDESCRIPTION as encounter_reason_description
FROM synthea.encounters;
