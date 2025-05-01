MODEL (
  name synthea.providers,
  kind SEED (
    path '$root/seeds/synthea/providers.csv'
  ),
  columns (
    Id TEXT,
    ORGANIZATION TEXT,
    NAME TEXT,
    GENDER TEXT,
    SPECIALITY TEXT,
    ADDRESS TEXT,
    CITY TEXT,
    STATE TEXT,
    ZIP TEXT,
    LAT REAL,
    LON REAL,
    UTILIZATION INT
  )
)