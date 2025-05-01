MODEL (
  name vocabulary.vocabulary,
  kind SEED (
    path '$root/seeds/vocabulary/vocabulary_seed.csv'
  ),
  columns (
    vocabulary_id TEXT,
    vocabulary_name TEXT,
    vocabulary_reference TEXT,
    vocabulary_version TEXT,
    vocabulary_concept_id INT
  )
)