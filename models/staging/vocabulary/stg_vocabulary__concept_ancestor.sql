MODEL (
  name stg.vocabulary__concept_ancestor,
  description "OMOP Concept Ancestor table",
  kind FULL,
  columns (
    ancestor_concept_id INT,
    descendant_concept_id INT,
    min_levels_of_separation INT,
    max_levels_of_separation INT
  ),
  column_descriptions (
    ancestor_concept_id = 'A foreign key to the Concept table for the higher-level Concept in the Concept Hierarchy.',
    descendant_concept_id = 'A foreign key to the Concept table for the lower-level Concept in the Concept Hierarchy.',
    min_levels_of_separation = 'The minimum number of levels of separation between the Ancestor and Descendant Concepts.',
    max_levels_of_separation = 'The maximum number of levels of separation between the Ancestor and Descendant Concepts.'
  )
);

SELECT
  ancestor_concept_id::INT AS ancestor_concept_id,
  descendant_concept_id::INT AS descendant_concept_id,
  min_levels_of_separation::INT AS min_levels_of_separation,
  max_levels_of_separation::INT AS max_levels_of_separation
FROM vocabulary.concept_ancestor