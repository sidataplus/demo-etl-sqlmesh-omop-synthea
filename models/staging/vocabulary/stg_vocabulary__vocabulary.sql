MODEL (
  name stg.vocabulary__vocabulary,
  description "OMOP Vocabulary table",
  kind FULL,
  columns (
    vocabulary_id TEXT,
    vocabulary_name TEXT,
    vocabulary_reference TEXT,
    vocabulary_version TEXT,
    vocabulary_concept_id INT
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
  vocabulary_id::TEXT AS vocabulary_id,
  vocabulary_name::TEXT AS vocabulary_name,
  vocabulary_reference::TEXT AS vocabulary_reference,
  vocabulary_version::TEXT AS vocabulary_version,
  vocabulary_concept_id::INT AS vocabulary_concept_id
FROM vocabulary.vocabulary