MODEL (
    name stg.vocabulary__domain,
    description "OMOP Domain table",
    kind FULL,
    columns (
        domain_id varchar,
        domain_name varchar,
        domain_concept_id int
    ),
    column_descriptions (
        domain_id = 'A unique identifier for the Domain.',
        domain_name = 'The name of the Domain.',
        domain_concept_id = 'A foreign key to the Concept table for the domain Concept itself.'
    )
);

SELECT
    domain_id::varchar as domain_id,
    domain_name::varchar as domain_name,
    domain_concept_id::int as domain_concept_id
FROM vocabulary.domain;
