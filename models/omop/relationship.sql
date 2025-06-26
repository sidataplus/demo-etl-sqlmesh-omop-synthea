MODEL (
  name omop.relationship,
  kind FULL,
  audits (
    relationship_defines_ancestry_is_required,
    relationship_is_hierarchical_is_required,
    relationship_relationship_concept_id_is_required,
    relationship_relationship_concept_id_is_foreign_key,
    relationship_relationship_id_is_required,
    relationship_relationship_id_is_primary_key,
    relationship_relationship_name_is_required,
    relationship_reverse_relationship_id_is_required
  )
);

SELECT
  *
FROM stg.vocabulary__relationship