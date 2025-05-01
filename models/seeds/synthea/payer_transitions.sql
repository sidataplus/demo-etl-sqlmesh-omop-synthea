MODEL (
  name synthea.payer_transitions,
  kind SEED (
    path '$root/seeds/synthea/payer_transitions.csv'
  ),
  columns (
    PATIENT TEXT,
    MEMBERID TEXT,
    START_YEAR TIMESTAMP,
    END_YEAR TIMESTAMP,
    PAYER TEXT,
    SECONDARY_PAYER TEXT,
    OWNERSHIP TEXT,
    OWNERNAME TEXT
  )
)