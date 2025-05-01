MODEL (
  name synthea.procedures,
  kind SEED (
    path '$root/seeds/synthea/procedures.csv'
  ),
  columns (
    START TIMESTAMP,
    STOP TIMESTAMP,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    CODE TEXT,
    DESCRIPTION TEXT,
    BASE_COST REAL,
    REASONCODE TEXT,
    REASONDESCRIPTION TEXT
  )
)