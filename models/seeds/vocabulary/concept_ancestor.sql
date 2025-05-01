MODEL (
  name vocabulary.concept_ancestor,
  kind SEED (
    path '$root/seeds/vocabulary/concept_ancestor_seed.csv'
  ),
  columns (
    ancestor_concept_id INT,
    descendant_concept_id INT,
    min_levels_of_separation INT,
    max_levels_of_separation INT
  )
)