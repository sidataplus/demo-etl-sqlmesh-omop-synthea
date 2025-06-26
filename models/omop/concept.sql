MODEL (
  name omop.concept,
  description 'The Standardized Vocabularies contains records, or Concepts, that uniquely identify each fundamental unit of meaning used to express clinical information in all domain tables of the CDM.',
  kind FULL,
  columns (
    concept_id INT,
    concept_name TEXT,
    domain_id TEXT,
    vocabulary_id TEXT,
    concept_class_id TEXT,
    standard_concept TEXT,
    concept_code TEXT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason TEXT
  ),
  column_descriptions (
    concept_id = 'A unique identifier for each Concept.',
    concept_name = 'The name of the Concept.',
    domain_id = 'A foreign key to the DOMAIN table indicating the domain of the Concept.',
    vocabulary_id = 'A foreign key to the VOCABULARY table indicating the vocabulary the Concept belongs to.',
    concept_class_id = 'A foreign key to the CONCEPT_CLASS table indicating the class of the Concept.',
    standard_concept = 'Indicates whether the Concept is standard (S), classification (C), or non-standard (empty).',
    concept_code = 'The code of the Concept in its source vocabulary.',
    valid_start_date = 'The date from which the Concept is valid.',
    valid_end_date = 'The date until which the Concept is valid.',
    invalid_reason = 'Reason for invalidation (D for deleted, U for updated).'
  ),
  audits (
    concept_concept_class_id_is_required,
    concept_concept_class_id_is_foreign_key,
    concept_concept_code_is_required,
    concept_concept_id_is_required,
    concept_concept_id_is_primary_key,
    concept_concept_name_is_required,
    concept_domain_id_is_required,
    concept_domain_id_is_foreign_key,
    concept_valid_end_date_is_required,
    concept_valid_start_date_is_required,
    concept_valid_start_date_start_before_end,
    concept_vocabulary_id_is_required,
    concept_vocabulary_id_is_foreign_key
  )
);

SELECT
  *
FROM stg.vocabulary__concept