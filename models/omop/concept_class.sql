MODEL (
  name omop.concept_class,
  kind FULL,
  description "The CONCEPT_CLASS table includes semantic categories that reference the source structure of each Vocabulary."
);

SELECT
    concept_class_id::VARCHAR(20),
    concept_class_name::VARCHAR(255),
    concept_class_concept_id::INT
FROM stg.vocabulary__concept_class