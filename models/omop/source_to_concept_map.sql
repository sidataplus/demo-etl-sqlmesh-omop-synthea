MODEL (
  name omop.source_to_concept_map,
  kind FULL,
  description "Maintains mappings from local source codes to Standard Concepts.",
  column_descriptions (
    source_code = "The source code being mapped.",
    source_concept_id = "A foreign key identifier to the Source Concept.",
    source_vocabulary_id = "A foreign key identifier to the Vocabulary of the source code.",
    source_code_description = "The description of the source code.",
    target_concept_id = "A foreign key identifier to the target Standard Concept.",
    target_vocabulary_id = "A foreign key identifier to the Vocabulary of the target Concept.",
    valid_start_date = "The date when the mapping is first valid.",
    valid_end_date = "The date when the mapping becomes invalid.",
    invalid_reason = "Reason the mapping was invalidated."
  )
);

-- Note: This table is typically populated during the ETL mapping process (e.g., using tools like Usagi)
-- or provided as part of vocabulary data. It's not directly generated from Synthea in this basic ETL.
-- Creating an empty table structure for compatibility.
SELECT
    CAST(NULL AS VARCHAR(50)) AS source_code,
    CAST(NULL AS INT) AS source_concept_id,
    CAST(NULL AS VARCHAR(20)) AS source_vocabulary_id,
    CAST(NULL AS VARCHAR(255)) AS source_code_description,
    CAST(NULL AS INT) AS target_concept_id,
    CAST(NULL AS VARCHAR(20)) AS target_vocabulary_id,
    CAST(NULL AS DATE) AS valid_start_date,
    CAST(NULL AS DATE) AS valid_end_date,
    CAST(NULL AS VARCHAR(1)) AS invalid_reason
WHERE 1 = 0