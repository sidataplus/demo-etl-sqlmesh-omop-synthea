MODEL (
  name vocabulary.concept_relationship,
  kind SEED (
    path '$root/seeds/vocabulary/concept_relationship_seed.csv'
  ),
  columns (
    concept_id_1 INT,
    concept_id_2 INT,
    relationship_id TEXT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason TEXT
  )
)