MODEL (
  name omop.vocabulary,
  kind FULL,
  description "Includes a list of the Vocabularies integrated from various sources or created de novo in OMOP CDM.",
  column_descriptions (vocabulary_id = "A unique identifier for each Vocabulary.", vocabulary_name = "The name describing the vocabulary.", vocabulary_reference = "External reference to documentation or download location.", vocabulary_version = "Version of the Vocabulary as indicated in the source.", vocabulary_concept_id = "A foreign key identifier to the Concept representing the Vocabulary.")
);

SELECT
  vocabulary_id::TEXT,
  vocabulary_name::TEXT,
  vocabulary_reference::TEXT,
  vocabulary_version::TEXT,
  vocabulary_concept_id::INT
FROM stg.vocabulary__vocabulary