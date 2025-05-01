MODEL (
  name synthea.organizations,
  kind SEED (
    path '$root/seeds/synthea/organizations.csv'
  ),
  columns (
    Id TEXT,
    NAME TEXT,
    ADDRESS TEXT,
    CITY TEXT,
    STATE TEXT,
    ZIP TEXT,
    LAT REAL,
    LON REAL,
    PHONE TEXT,
    REVENUE REAL,
    UTILIZATION INT
  )
)