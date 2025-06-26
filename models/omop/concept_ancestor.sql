MODEL (
  name omop.concept_ancestor,
  kind FULL,
  description "The CONCEPT_ANCESTOR table is designed to simplify observational analysis by providing the complete hierarchical relationships between Concepts.",
  columns (
    ancestor_concept_id INT,
    descendant_concept_id INT,
    min_levels_of_separation INT,
    max_levels_of_separation INT
  ),
  column_descriptions (
    ancestor_concept_id = 'The Concept Id for the higher-level concept that forms the ancestor in the relationship.',
    descendant_concept_id = 'The Concept Id for the lower-level concept that forms the descendant in the relationship.',
    min_levels_of_separation = 'The minimum number of levels separating the ancestor and descendant concepts.',
    max_levels_of_separation = 'The maximum number of levels separating the ancestor and descendant concepts.'
  ),
  audits (
    concept_ancestor_ancestor_concept_id_is_required,
    concept_ancestor_ancestor_concept_id_is_foreign_key,
    concept_ancestor_descendant_concept_id_is_required,
    concept_ancestor_descendant_concept_id_is_foreign_key,
    concept_ancestor_max_levels_of_separation_is_required,
    concept_ancestor_min_levels_of_separation_is_required
  )
);

SELECT
  ancestor_concept_id::INT,
  descendant_concept_id::INT,
  min_levels_of_separation::INT,
  max_levels_of_separation::INT
FROM stg.vocabulary__concept_ancestor