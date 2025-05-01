MODEL (
  name vocabulary.domain,
  kind SEED (
    path '$root/seeds/vocabulary/domain_seed.csv'
  ),
  columns (
    domain_id TEXT,
    domain_name TEXT,
    domain_concept_id INT
  )
)