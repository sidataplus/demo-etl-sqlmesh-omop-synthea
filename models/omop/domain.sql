MODEL (
  name omop.domain,
  kind FULL,
  description "The DOMAIN table includes a list of OMOP-defined Domains to which the Concepts of the Standardized Vocabularies can belong.",
  columns (
    domain_id VARCHAR(20),
    domain_name VARCHAR(255),
    domain_concept_id INT
  ),
  column_descriptions (
    domain_id = 'A unique key for each domain.',
    domain_name = 'The name describing the Domain.',
    domain_concept_id = 'A Concept representing the Domain Concept the DOMAIN record belongs to.'
  )
);

SELECT
    domain_id::VARCHAR(20),
    domain_name::VARCHAR(255),
    domain_concept_id::INT
FROM stg.vocabulary__domain;
