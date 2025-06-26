MODEL (
  name stg.vocabulary__relationship,
  description "OMOP Relationship table",
  kind FULL,
  columns (
    relationship_id TEXT,
    relationship_name TEXT,
    is_hierarchical TEXT, /* dbt model uses boolean, but source might be varchar '1'/'0' */
    defines_ancestry TEXT, /* dbt model uses boolean, but source might be varchar '1'/'0' */
    reverse_relationship_id TEXT,
    relationship_concept_id INT
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
  relationship_id::TEXT AS relationship_id,
  relationship_name::TEXT AS relationship_name,
  is_hierarchical::TEXT AS is_hierarchical,
  defines_ancestry::TEXT AS defines_ancestry,
  reverse_relationship_id::TEXT AS reverse_relationship_id,
  relationship_concept_id::INT AS relationship_concept_id
FROM vocabulary.relationship