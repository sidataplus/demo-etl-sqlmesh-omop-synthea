MODEL (
  name int.source_to_source_vocab_map,
  description "Source to source vocabulary mapping based on concept table",
  kind FULL,
  columns (
    source_code TEXT,
    source_concept_id INT,
    source_code_description TEXT,
    source_vocabulary_id TEXT,
    source_domain_id TEXT,
    source_concept_class_id TEXT,
    source_valid_start_date DATE,
    source_valid_end_date DATE,
    source_invalid_reason TEXT,
    target_concept_id INT,
    target_concept_name TEXT,
    target_vocabulary_id TEXT,
    target_domain_id TEXT,
    target_concept_class_id TEXT,
    target_invalid_reason TEXT,
    target_standard_concept TEXT
  )
);

JINJA_QUERY_BEGIN;
SELECT
    c.concept_code AS source_code
    , c.concept_id AS source_concept_id
    , c.concept_name AS source_code_description
    , c.vocabulary_id AS source_vocabulary_id
    , c.domain_id AS source_domain_id
    , c.concept_class_id AS source_concept_class_id
    , c.valid_start_date AS source_valid_start_date
    , c.valid_end_date AS source_valid_end_date
    , c.invalid_reason AS source_invalid_reason
    , c.concept_id AS target_concept_id
    , c.concept_name AS target_concept_name
    , c.vocabulary_id AS target_vocabulary_id
    , c.domain_id AS target_domain_id
    , c.concept_class_id AS target_concept_class_id
    , c.invalid_reason AS target_invalid_reason
    , c.standard_concept AS target_standard_concept
FROM stg.vocabulary__concept AS c
JINJA_END;