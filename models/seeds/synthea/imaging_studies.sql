MODEL (
  name synthea.imaging_studies,
  kind SEED (
    path '$root/seeds/synthea/imaging_studies.csv'
  ),
  columns (
    Id TEXT,
    DATE TIMESTAMP,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    SERIES_UID TEXT,
    BODYSITE_CODE TEXT,
    BODYSITE_DESCRIPTION TEXT,
    MODALITY_CODE TEXT,
    MODALITY_DESCRIPTION TEXT,
    INSTANCE_UID TEXT,
    SOP_CODE TEXT,
    SOP_DESCRIPTION TEXT,
    PROCEDURE_CODE TEXT
  )
)