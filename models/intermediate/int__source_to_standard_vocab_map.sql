MODEL (
    name int.source_to_standard_vocab_map,
    description "Source to standard vocabulary mapping using concept and concept_relationship tables",
    kind FULL,
    columns (
        source_code VARCHAR,
        source_concept_id INT,
        source_code_description VARCHAR,
        source_vocabulary_id VARCHAR,
        source_domain_id VARCHAR,
        source_concept_class_id VARCHAR,
        source_valid_start_date DATE,
        source_valid_end_date DATE,
        source_invalid_reason VARCHAR,
        target_concept_id INT,
        target_concept_name VARCHAR,
        target_vocabulary_id VARCHAR,
        target_domain_id VARCHAR,
        target_concept_class_id VARCHAR,
        target_invalid_reason VARCHAR,
        target_standard_concept VARCHAR
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
    , c1.concept_id AS target_concept_id
    , c1.concept_name AS target_concept_name
    , c1.vocabulary_id AS target_vocabulary_id
    , c1.domain_id AS target_domain_id
    , c1.concept_class_id AS target_concept_class_id
    , c1.invalid_reason AS target_invalid_reason
    , c1.standard_concept AS target_standard_concept
FROM stg.vocabulary__concept AS c
INNER JOIN stg.vocabulary__concept_relationship AS cr
    ON
        c.concept_id = cr.concept_id_1
        AND cr.invalid_reason IS null
        AND lower(cr.relationship_id) = 'maps to'
INNER JOIN stg.vocabulary__concept AS c1
    ON
        cr.concept_id_2 = c1.concept_id
        AND c1.invalid_reason IS null

JINJA_END;
