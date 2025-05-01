MODEL (
  name synthea.conditions,
  kind SEED (
    path '$root/seeds/synthea/conditions.csv'
  ),
  columns (
    START DATE,
    STOP DATE,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    CODE TEXT,
    DESCRIPTION TEXT
  )
)