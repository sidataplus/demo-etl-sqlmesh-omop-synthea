MODEL (
    name stg.vocabulary__concept_synonym,
    description "OMOP Concept Synonym table",
    kind FULL,
    columns (
        concept_id int,
        concept_synonym_name varchar,
        language_concept_id int
    ),
    column_descriptions (
        concept_id = 'A foreign key to the Concept in which the synonym is used.',
        concept_synonym_name = 'The text of the synonym for the Concept.',
        language_concept_id = 'A foreign key to the Concept table defining the language of the synonym.'
    )
);

SELECT
    concept_id::int as concept_id,
    concept_synonym_name::varchar as concept_synonym_name,
    language_concept_id::int as language_concept_id
FROM vocabulary.concept_synonym;
