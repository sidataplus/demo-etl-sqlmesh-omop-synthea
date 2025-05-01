MODEL (
  name vocabulary.concept_synonym,
  kind SEED (
    path '$root/seeds/vocabulary/concept_synonym_seed.csv'
  ),
  columns (
    concept_id INT,
    concept_synonym_name TEXT,
    language_concept_id INT
  )
)