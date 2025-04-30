MODEL (
    name stg.synthea__devices,
    description "Synthea devices table",
    kind VIEW,
    columns (
        device_start_datetime timestamp,
        device_start_date date,
        device_stop_datetime timestamp,
        device_stop_date date,
        patient_id varchar,
        encounter_id varchar,
        device_code varchar,
        device_description varchar,
        udi varchar
    ),
    column_descriptions (
        device_start_datetime = 'The date and time the device was associated to the patient.',
        device_start_date = 'The date the device was associated to the patient.',
        device_stop_datetime = 'The date and time the device was removed, if applicable.',
        device_stop_date = 'The date the device was removed, if applicable.',
        patient_id = 'The patient ID.',
        encounter_id = 'The encounter ID.',
        device_code = 'The device code.',
        device_description = 'The device description.',
        udi = 'Unique Device Identifier.'
    )
);

SELECT
    START as device_start_datetime,
    CAST(START as date) as device_start_date,
    STOP as device_stop_datetime,
    CAST(STOP as date) as device_stop_date,
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    CODE as device_code,
    DESCRIPTION as device_description,
    UDI as udi
FROM synthea.devices;
