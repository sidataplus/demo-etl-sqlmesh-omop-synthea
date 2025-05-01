MODEL (
  name synthea.careplans,
  kind SEED (
    path '$root/seeds/synthea/careplans.csv'
  ),
  columns (
    Id TEXT,
    START DATE,
    STOP DATE,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    CODE TEXT,
    DESCRIPTION TEXT,
    REASONCODE TEXT,
    REASONDESCRIPTION TEXT
  )
)