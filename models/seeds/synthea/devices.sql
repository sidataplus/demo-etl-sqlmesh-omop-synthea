MODEL (
  name synthea.devices,
  kind SEED (
    path '$root/seeds/synthea/devices.csv'
  ),
  columns (
    START TIMESTAMP,
    STOP TIMESTAMP,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    CODE TEXT,
    DESCRIPTION TEXT,
    UDI TEXT
  )
)