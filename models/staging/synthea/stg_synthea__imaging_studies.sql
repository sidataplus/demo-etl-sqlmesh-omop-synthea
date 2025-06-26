MODEL (
  name stg.synthea__imaging_studies,
  description "Synthea imaging studies table",
  kind VIEW,
  columns (
    imaging_id TEXT,
    imaging_datetime TIMESTAMP,
    patient_id TEXT,
    encounter_id TEXT,
    series_uid TEXT,
    bodysite_code TEXT,
    bodysite_description TEXT,
    modality_code TEXT,
    modality_description TEXT,
    instance_uid TEXT,
    sop_code TEXT,
    sop_description TEXT,
    imaging_procedure_code TEXT
  ),
  column_descriptions (
    imaging_id = 'Unique identifier for the imaging study.',
    imaging_datetime = 'The date and time of the imaging study.',
    patient_id = 'The patient ID.',
    encounter_id = 'The encounter ID.',
    series_uid = 'Series UID.',
    bodysite_code = 'Bodysite code.',
    bodysite_description = 'Bodysite description.',
    modality_code = 'A DICOM-DCM code describing the method used to take the images.',
    modality_description = 'Modality description.',
    instance_uid = 'Instance UID.',
    sop_code = 'A DICOM-SOP code describing the Subject-Object Pair (SOP) that constitutes the image.',
    sop_description = 'SOP description.',
    imaging_procedure_code = 'Imaging procedure code.'
  )
);

SELECT
  ID AS imaging_id,
  DATE AS imaging_datetime,
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  SERIES_UID AS series_uid,
  BODYSITE_CODE AS bodysite_code,
  BODYSITE_DESCRIPTION AS bodysite_description,
  MODALITY_CODE AS modality_code,
  MODALITY_DESCRIPTION AS modality_description,
  INSTANCE_UID AS instance_uid,
  SOP_CODE AS sop_code,
  SOP_DESCRIPTION AS sop_description,
  PROCEDURE_CODE AS imaging_procedure_code
FROM synthea.imaging_studies