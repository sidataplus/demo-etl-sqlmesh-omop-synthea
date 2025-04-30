MODEL (
    name stg.vocabulary__concept,
    description "OMOP Concept table",
    kind FULL,
    columns (
        concept_id int,
        concept_name varchar,
        domain_id varchar,
        vocabulary_id varchar,
        concept_class_id varchar,
        standard_concept varchar,
        concept_code varchar,
        valid_start_date date,
        valid_end_date date,
        invalid_reason varchar
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
    concept_id::int as concept_id,
    concept_name::varchar as concept_name,
    domain_id::varchar as domain_id,
    vocabulary_id::varchar as vocabulary_id,
    concept_class_id::varchar as concept_class_id,
    standard_concept::varchar as standard_concept,
    concept_code::varchar as concept_code,
    valid_start_date::date as valid_start_date,
    valid_end_date::date as valid_end_date,
    invalid_reason::varchar as invalid_reason
FROM vocabulary.concept;
