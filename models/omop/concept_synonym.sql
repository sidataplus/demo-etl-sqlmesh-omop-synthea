MODEL (
  name omop.concept_synonym,
  kind FULL,
  description "The CONCEPT_SYNONYM table is used to store alternate names and descriptions for Concepts.",
  columns (
    concept_id INT,
    concept_synonym_name VARCHAR(1000),
    language_concept_id INT
  ),
  column_descriptions (
    concept_id = 'A foreign key to the Concept in the CONCEPT table.',
    concept_synonym_name = 'An alternate name for the Concept.',
    language_concept_id = 'A foreign key to the Concept for the language of the synonym.'
  )
);

SELECT
    concept_id::INT,
    concept_synonym_name::VARCHAR(1000),
    language_concept_id::INT
FROM stg.vocabulary__concept_synonym