MODEL (
  name stg.vocabulary__concept_synonym,
  description "OMOP Concept Synonym table",
  kind FULL,
  columns (
    concept_id INT,
    concept_synonym_name TEXT,
    language_concept_id INT
  ),
  column_descriptions (concept_id = 'A foreign key to the Concept in which the synonym is used.', concept_synonym_name = 'The text of the synonym for the Concept.', language_concept_id = 'A foreign key to the Concept table defining the language of the synonym.')
);

SELECT
  concept_id::INT AS concept_id,
  concept_synonym_name::TEXT AS concept_synonym_name,
  language_concept_id::INT AS language_concept_id
FROM vocabulary.concept_synonym