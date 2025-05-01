MODEL (
  name stg.vocabulary__concept_relationship,
  description "OMOP Concept Relationship table",
  kind FULL,
  columns (
    concept_id_1 INT,
    concept_id_2 INT,
    relationship_id TEXT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason TEXT
  ),
  column_descriptions (concept_id_1 = 'A foreign key to the Concept table for the first Concept in the relationship.', concept_id_2 = 'A foreign key to the Concept table for the second Concept in the relationship.', relationship_id = 'A foreign key to the Relationship table defining the nature of the relationship.', valid_start_date = 'The date when the relationship was first recorded.', valid_end_date = 'The date when the relationship became invalid because it was deleted or superseded.', invalid_reason = 'Reason the relationship was invalidated. Possible values are D (deleted), U (updated), or empty for valid relationships.')
);

SELECT
  concept_id_1::INT AS concept_id_1,
  concept_id_2::INT AS concept_id_2,
  relationship_id::TEXT AS relationship_id,
  valid_start_date::DATE AS valid_start_date,
  valid_end_date::DATE AS valid_end_date,
  invalid_reason::TEXT AS invalid_reason
FROM vocabulary.concept_relationship