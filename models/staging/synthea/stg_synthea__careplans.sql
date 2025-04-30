MODEL (
    name stg.synthea__careplans,
    description "Synthea careplans table",
    kind VIEW,
    columns (
        careplan_id varchar,
        careplan_start_date date,
        careplan_stop_date date,
        patient_id varchar,
        encounter_id varchar,
        careplan_code varchar,
        careplan_description varchar,
        careplan_reason_code varchar,
        careplan_reason_description varchar
    ),
    column_descriptions (
        careplan_id = 'Unique identifier for the careplan.',
        careplan_start_date = 'The date the careplan was initiated.',
        careplan_stop_date = 'The date the careplan ended, if applicable.',
        patient_id = 'The patient ID.',
        encounter_id = 'The encounter ID.',
        careplan_code = 'The careplan code.',
        careplan_description = 'The careplan description.',
        careplan_reason_code = 'Diagnosis code from SNOMED-CT that this care plan addresses.',
        careplan_reason_description = 'Description of the reason code.'
    )
);

SELECT
    ID as careplan_id,
    START as careplan_start_date,
    STOP as careplan_stop_date,
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    CODE as careplan_code,
    DESCRIPTION as careplan_description,
    REASONCODE as careplan_reason_code,
    REASONDESCRIPTION as careplan_reason_description
FROM synthea.careplans;
