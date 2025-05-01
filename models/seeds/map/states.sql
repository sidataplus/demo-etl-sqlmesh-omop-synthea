MODEL (
  name map.states,
  kind SEED (
    path '$root/seeds/map/states.csv'
  ),
  columns (
    state_name TEXT,
    state_abbreviation TEXT
  )
)