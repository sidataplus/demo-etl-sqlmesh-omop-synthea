MODEL (
  name synthea.medications,
  kind SEED (
    path '$root/seeds/synthea/medications.csv'
  ),
  columns (
    START TIMESTAMP,
    STOP TIMESTAMP,
    PATIENT TEXT,
    PAYER TEXT,
    ENCOUNTER TEXT,
    CODE TEXT,
    DESCRIPTION TEXT,
    BASE_COST REAL,
    PAYER_COVERAGE REAL,
    DISPENSES INT,
    TOTALCOST REAL,
    REASONCODE TEXT,
    REASONDESCRIPTION TEXT
  )
)