MODEL (
    name stg.vocabulary__concept_class,
    description "OMOP Concept Class table",
    kind FULL,
    columns (
        concept_class_id varchar,
        concept_class_name varchar,
        concept_class_concept_id int
    ),
    column_descriptions (
        concept_class_id = 'A unique identifier for the Concept Class.',
        concept_class_name = 'The name of the Concept Class.',
        concept_class_concept_id = 'A foreign key to the Concept table for the Concept Class itself.'
    )
);

SELECT
    concept_class_id::varchar as concept_class_id,
    concept_class_name::varchar as concept_class_name,
    concept_class_concept_id::int as concept_class_concept_id
FROM vocabulary.concept_class;
