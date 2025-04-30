MODEL (
    name stg.synthea__imaging_studies,
    description "Synthea imaging studies table",
    kind VIEW,
    columns (
        imaging_id varchar,
        imaging_datetime timestamp,
        patient_id varchar,
        encounter_id varchar,
        series_uid varchar,
        bodysite_code varchar,
        bodysite_description varchar,
        modality_code varchar,
        modality_description varchar,
        instance_uid varchar,
        sop_code varchar,
        sop_description varchar,
        imaging_procedure_code varchar
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
    ID as imaging_id,
    DATE as imaging_datetime,
    PATIENT as patient_id,
    ENCOUNTER as encounter_id,
    SERIES_UID as series_uid,
    BODYSITE_CODE as bodysite_code,
    BODYSITE_DESCRIPTION as bodysite_description,
    MODALITY_CODE as modality_code,
    MODALITY_DESCRIPTION as modality_description,
    INSTANCE_UID as instance_uid,
    SOP_CODE as sop_code,
    SOP_DESCRIPTION as sop_description,
    PROCEDURE_CODE as imaging_procedure_code
FROM synthea.imaging_studies;
