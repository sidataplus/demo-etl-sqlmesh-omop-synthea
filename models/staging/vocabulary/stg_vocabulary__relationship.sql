MODEL (
    name stg.vocabulary__relationship,
    description "OMOP Relationship table",
    kind FULL,
    columns (
        relationship_id varchar,
        relationship_name varchar,
        is_hierarchical varchar, -- dbt model uses boolean, but source might be varchar '1'/'0'
        defines_ancestry varchar, -- dbt model uses boolean, but source might be varchar '1'/'0'
        reverse_relationship_id varchar,
        relationship_concept_id int
    ),
    column_descriptions (
        relationship_id = 'A unique identifier for the Relationship.',
        relationship_name = 'The text name or description of the Relationship.',
        is_hierarchical = 'Defines whether a relationship defines concepts into classes or hierarchies.',
        defines_ancestry = 'Defines whether a hierarchical relationship contributes to the concept_ancestor table.',
        reverse_relationship_id = 'A foreign key to the Relationship table identifying the reverse relationship.',
        relationship_concept_id = 'A foreign key to the Concept table identifying the relationship Concept.'
    )
);

SELECT
    relationship_id::varchar as relationship_id,
    relationship_name::varchar as relationship_name,
    is_hierarchical::varchar as is_hierarchical,
    defines_ancestry::varchar as defines_ancestry,
    reverse_relationship_id::varchar as reverse_relationship_id,
    relationship_concept_id::int as relationship_concept_id
FROM vocabulary.relationship;
