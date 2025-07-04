MODEL (
  name synthea.allergies,
  kind SEED (
    path '$root/seeds/synthea/allergies.csv'
  ),
  columns (
    START DATE,
    STOP DATE,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    CODE TEXT,
    SYSTEM TEXT,
    DESCRIPTION TEXT,
    TYPE TEXT,
    CATEGORY TEXT,
    REACTION1 TEXT,
    DESCRIPTION1 TEXT,
    SEVERITY1 TEXT,
    REACTION2 TEXT,
    DESCRIPTION2 TEXT,
    SEVERITY2 TEXT
  )
)