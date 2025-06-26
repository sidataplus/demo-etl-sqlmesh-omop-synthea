MODEL (
  name omop.concept_synonym,
  kind FULL,
  description "The CONCEPT_SYNONYM table is used to store alternate names and descriptions for Concepts.",
  columns (
    concept_id INT,
    concept_synonym_name TEXT,
    language_concept_id INT
  ),
  column_descriptions (
    concept_id = 'A foreign key to the Concept in the CONCEPT table.',
    concept_synonym_name = 'An alternate name for the Concept.',
    language_concept_id = 'A foreign key to the Concept for the language of the synonym.'
  ),
  audits (
    concept_synonym_concept_id_is_required,
    concept_synonym_concept_id_is_foreign_key,
    concept_synonym_concept_synonym_name_is_required,
    concept_synonym_language_concept_id_is_required,
    concept_synonym_language_concept_id_is_foreign_key
  )
);

SELECT
  concept_id::INT,
  concept_synonym_name::TEXT,
  language_concept_id::INT
FROM stg.vocabulary__concept_synonym