MODEL (
  name stg.vocabulary__concept_class,
  description "OMOP Concept Class table",
  kind FULL,
  columns (
    concept_class_id TEXT,
    concept_class_name TEXT,
    concept_class_concept_id INT
  ),
  column_descriptions (
    concept_class_id = 'A unique identifier for the Concept Class.',
    concept_class_name = 'The name of the Concept Class.',
    concept_class_concept_id = 'A foreign key to the Concept table for the Concept Class itself.'
  )
);

SELECT
  concept_class_id::TEXT AS concept_class_id,
  concept_class_name::TEXT AS concept_class_name,
  concept_class_concept_id::INT AS concept_class_concept_id
FROM vocabulary.concept_class