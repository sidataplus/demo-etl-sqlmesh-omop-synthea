MODEL (
    name stg.synthea__medications,
    description "Synthea medications table",
    kind VIEW,
    columns (
        medication_start_datetime timestamp,
        medication_start_date date,
        medication_stop_datetime timestamp,
        medication_stop_date date,
        patient_id varchar,
        payer_id varchar,
        encounter_id varchar,
        medication_code varchar,
        medication_description varchar,
        medication_base_cost double,
        medication_payer_coverage double,
        dispenses int,
        medication_total_cost double,
        medication_reason_code varchar,
        medication_reason_description varchar
    ),
    column_descriptions (
        medication_start_datetime = 'The start date and time of the medication.',
        medication_start_date = 'The start date of the medication.',
        medication_stop_datetime = 'The stop date and time of the medication.',
        medication_stop_date = 'The stop date of the medication.',
        patient_id = 'The patient ID.',
        payer_id = 'The payer ID.',
        encounter_id = 'The encounter ID.',
        medication_code = 'The medication code.',
        medication_description = 'The medication description.',
        medication_base_cost = 'The line item cost of the medication.',
        medication_payer_coverage = 'The amount of cost covered by the payer.',
        dispenses = 'The number of times the prescription was filled.',
        medication_total_cost = 'The total cost of the prescription, including all dispenses.',
        medication_reason_code = 'Diagnosis code from SNOMED-CT specifying why this medication was prescribed.',
        medication_reason_description = 'Description of the reason code.'
    )
);

SELECT
    START as medication_start_datetime,
    CAST(START as date) as medication_start_date,
    STOP as medication_stop_datetime,
    CAST(STOP as date) as medication_stop_date,
    PATIENT as patient_id,
    PAYER as payer_id,
    ENCOUNTER as encounter_id,
    CODE as medication_code,
    DESCRIPTION as medication_description,
    BASE_COST as medication_base_cost,
    PAYER_COVERAGE as medication_payer_coverage,
    DISPENSES as dispenses,
    TOTALCOST as medication_total_cost,
    REASONCODE as medication_reason_code,
    REASONDESCRIPTION as medication_reason_description
FROM synthea.medications;
