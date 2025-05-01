MODEL (
  name stg.vocabulary__domain,
  description "OMOP Domain table",
  kind FULL,
  columns (
    domain_id TEXT,
    domain_name TEXT,
    domain_concept_id INT
  ),
  column_descriptions (domain_id = 'A unique identifier for the Domain.', domain_name = 'The name of the Domain.', domain_concept_id = 'A foreign key to the Concept table for the domain Concept itself.')
);

SELECT
  domain_id::TEXT AS domain_id,
  domain_name::TEXT AS domain_name,
  domain_concept_id::INT AS domain_concept_id
FROM vocabulary.domain