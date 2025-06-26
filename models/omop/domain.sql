MODEL (
  name omop.domain,
  kind FULL,
  description "The DOMAIN table includes a list of OMOP-defined Domains to which the Concepts of the Standardized Vocabularies can belong.",
  columns (
    domain_id TEXT,
    domain_name TEXT,
    domain_concept_id INT
  ),
  column_descriptions (
    domain_id = 'A unique key for each domain.',
    domain_name = 'The name describing the Domain.',
    domain_concept_id = 'A Concept representing the Domain Concept the DOMAIN record belongs to.'
  ),
  audits (
    domain_domain_concept_id_is_required,
    domain_domain_concept_id_is_foreign_key,
    domain_domain_id_is_required,
    domain_domain_id_is_primary_key,
    domain_domain_name_is_required
  )
);

SELECT
  domain_id::TEXT,
  domain_name::TEXT,
  domain_concept_id::INT
FROM stg.vocabulary__domain