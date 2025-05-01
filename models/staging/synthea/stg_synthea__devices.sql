MODEL (
  name stg.synthea__devices,
  description "Synthea devices table",
  kind VIEW,
  columns (
    device_start_datetime TIMESTAMP,
    device_start_date DATE,
    device_stop_datetime TIMESTAMP,
    device_stop_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    device_code TEXT,
    device_description TEXT,
    udi TEXT
  ),
  column_descriptions (device_start_datetime = 'The date and time the device was associated to the patient.', device_start_date = 'The date the device was associated to the patient.', device_stop_datetime = 'The date and time the device was removed, if applicable.', device_stop_date = 'The date the device was removed, if applicable.', patient_id = 'The patient ID.', encounter_id = 'The encounter ID.', device_code = 'The device code.', device_description = 'The device description.', udi = 'Unique Device Identifier.')
);

SELECT
  START AS device_start_datetime,
  START::DATE AS device_start_date,
  STOP AS device_stop_datetime,
  STOP::DATE AS device_stop_date,
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  CODE AS device_code,
  DESCRIPTION AS device_description,
  UDI AS udi
FROM synthea.devices