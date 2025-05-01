MODEL (
    name omop.concept,
    description 'The Standardized Vocabularies contains records, or Concepts, that uniquely identify each fundamental unit of meaning used to express clinical information in all domain tables of the CDM.',
    kind FULL,
    columns (
        concept_id INT,
        concept_name VARCHAR,
        domain_id VARCHAR,
        vocabulary_id VARCHAR,
        concept_class_id VARCHAR,
        standard_concept VARCHAR,
        concept_code VARCHAR,
        valid_start_date DATE,
        valid_end_date DATE,
        invalid_reason VARCHAR
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
    )
);

SELECT * FROM stg.vocabulary__concept;