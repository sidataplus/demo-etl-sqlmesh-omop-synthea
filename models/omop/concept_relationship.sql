MODEL (
  name omop.concept_relationship,
  description 'The CONCEPT_RELATIONSHIP table contains records that define relationships between any two Concepts and the nature or type of the relationship.',
  kind FULL,
  columns (
    concept_id_1 INT,
    concept_id_2 INT,
    relationship_id TEXT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason TEXT
  ),
  column_descriptions (
    concept_id_1 = 'A foreign key to the first Concept in the relationship.',
    concept_id_2 = 'A foreign key to the second Concept in the relationship.',
    relationship_id = 'A foreign key to the RELATIONSHIP table defining the type of relationship.',
    valid_start_date = 'The date when the relationship became valid.',
    valid_end_date = 'The date when the relationship became invalid.',
    invalid_reason = 'Reason the relationship was invalidated.'
  ),
  audits (
    concept_relationship_concept_id_1_is_required,
    concept_relationship_concept_id_1_is_foreign_key,
    concept_relationship_concept_id_2_is_required,
    concept_relationship_concept_id_2_is_foreign_key,
    concept_relationship_relationship_id_is_required,
    concept_relationship_relationship_id_is_foreign_key,
    concept_relationship_valid_end_date_is_required,
    concept_relationship_valid_start_date_is_required,
    concept_relationship_valid_start_date_start_before_end
  )
);

SELECT
  *
FROM stg.vocabulary__concept_relationship