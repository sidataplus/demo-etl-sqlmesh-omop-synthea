MODEL (
  name synthea.supplies,
  kind SEED (
    path '$root/seeds/synthea/supplies.csv'
  ),
  columns (
    DATE DATE,
    PATIENT TEXT,
    ENCOUNTER TEXT,
    CODE TEXT,
    DESCRIPTION TEXT,
    QUANTITY INT
  )
)