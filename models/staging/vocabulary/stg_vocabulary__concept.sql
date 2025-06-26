MODEL (
  name stg.vocabulary__concept,
  description "OMOP Concept table",
  kind FULL,
  columns (
    concept_id INT,
    concept_name TEXT,
    domain_id TEXT,
    vocabulary_id TEXT,
    concept_class_id TEXT,
    standard_concept TEXT,
    concept_code TEXT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason TEXT
  ),
  column_descriptions (
    concept_id = 'A unique identifier for each Concept across all domains.',
    concept_name = 'An unambiguous, meaningful and descriptive name for the Concept.',
    domain_id = 'A foreign key to the Domain table the Concept belongs to.',
    vocabulary_id = 'A foreign key to the Vocabulary table the Concept originates from.',
    concept_class_id = 'A foreign key to the Concept_Class table indicating the type of Concept.',
    standard_concept = 'An indicator of whether the Concept is standard (S), classification (C) or non-standard (empty). Standard Concepts are used as the reference Concepts for the given domain.',
    concept_code = 'The concept code represents the identifier of the Concept in the source vocabulary.',
    valid_start_date = 'The date when the Concept was first recorded. The date is extracted from the source.',
    valid_end_date = 'The date when the Concept became invalid because it was deleted or superseded (updated) by a new concept. The default value is 31-Dec-2099.',
    invalid_reason = 'Reason the Concept was invalidated. Possible values are D (deleted), U (updated), or empty for valid concepts.'
  )
);

SELECT
  concept_id::INT AS concept_id,
  concept_name::TEXT AS concept_name,
  domain_id::TEXT AS domain_id,
  vocabulary_id::TEXT AS vocabulary_id,
  concept_class_id::TEXT AS concept_class_id,
  standard_concept::TEXT AS standard_concept,
  concept_code::TEXT AS concept_code,
  valid_start_date::DATE AS valid_start_date,
  valid_end_date::DATE AS valid_end_date,
  invalid_reason::TEXT AS invalid_reason
FROM vocabulary.concept