MODEL (
    name stg.vocabulary__vocabulary,
    description "OMOP Vocabulary table",
    kind FULL,
    columns (
        vocabulary_id varchar,
        vocabulary_name varchar,
        vocabulary_reference varchar,
        vocabulary_version varchar,
        vocabulary_concept_id int
    ),
    column_descriptions (
        vocabulary_id = 'A unique identifier for the Vocabulary.',
        vocabulary_name = 'The name of the Vocabulary.',
        vocabulary_reference = 'A reference to the source of the Vocabulary, such as a URL.',
        vocabulary_version = 'The version of the Vocabulary.',
        vocabulary_concept_id = 'A foreign key to the Concept table for the Vocabulary Concept itself.'
    )
);

SELECT
    vocabulary_id::varchar as vocabulary_id,
    vocabulary_name::varchar as vocabulary_name,
    vocabulary_reference::varchar as vocabulary_reference,
    vocabulary_version::varchar as vocabulary_version,
    vocabulary_concept_id::int as vocabulary_concept_id
FROM vocabulary.vocabulary;
