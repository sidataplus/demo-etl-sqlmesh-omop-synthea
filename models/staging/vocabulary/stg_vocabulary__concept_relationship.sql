MODEL (
    name stg.vocabulary__concept_relationship,
    description "OMOP Concept Relationship table",
    kind FULL,
    columns (
        concept_id_1 int,
        concept_id_2 int,
        relationship_id varchar,
        valid_start_date date,
        valid_end_date date,
        invalid_reason varchar
    ),
    column_descriptions (
        concept_id_1 = 'A foreign key to the Concept table for the first Concept in the relationship.',
        concept_id_2 = 'A foreign key to the Concept table for the second Concept in the relationship.',
        relationship_id = 'A foreign key to the Relationship table defining the nature of the relationship.',
        valid_start_date = 'The date when the relationship was first recorded.',
        valid_end_date = 'The date when the relationship became invalid because it was deleted or superseded.',
        invalid_reason = 'Reason the relationship was invalidated. Possible values are D (deleted), U (updated), or empty for valid relationships.'
    )
);

SELECT
    concept_id_1::int as concept_id_1,
    concept_id_2::int as concept_id_2,
    relationship_id::varchar as relationship_id,
    valid_start_date::date as valid_start_date,
    valid_end_date::date as valid_end_date,
    invalid_reason::varchar as invalid_reason
FROM vocabulary.concept_relationship;
