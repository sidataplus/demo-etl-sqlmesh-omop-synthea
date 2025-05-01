MODEL (
  name synthea.patients,
  kind SEED (
    path '$root/seeds/synthea/patients.csv'
  ),
  columns (
    Id TEXT,
    BIRTHDATE DATE,
    DEATHDATE DATE,
    SSN TEXT,
    DRIVERS TEXT,
    PASSPORT TEXT,
    PREFIX TEXT,
    FIRST TEXT,
    LAST TEXT,
    SUFFIX TEXT,
    MAIDEN TEXT,
    MARITAL TEXT,
    RACE TEXT,
    ETHNICITY TEXT,
    GENDER TEXT,
    BIRTHPLACE TEXT,
    ADDRESS TEXT,
    CITY TEXT,
    STATE TEXT,
    COUNTY TEXT,
    ZIP TEXT,
    LAT REAL,
    LON REAL,
    HEALTHCARE_EXPENSES REAL,
    HEALTHCARE_COVERAGE REAL
  )
)