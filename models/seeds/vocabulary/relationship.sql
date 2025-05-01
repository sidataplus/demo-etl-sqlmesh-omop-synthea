MODEL (
  name vocabulary.relationship,
  kind SEED (
    path '$root/seeds/vocabulary/relationship_seed.csv'
  ),
  columns (
    relationship_id TEXT,
    relationship_name TEXT,
    is_hierarchical TEXT,
    defines_ancestry TEXT,
    reverse_relationship_id TEXT,
    relationship_concept_id INT
  )
)