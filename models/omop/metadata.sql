MODEL (
  name omop.metadata,
  kind FULL,
  description "The METADATA table contains metadata information about a dataset that has been transformed to the OMOP Common Data Model.",
  columns (
    metadata_id BIGINT,
    metadata_concept_id INT,
    metadata_type_concept_id INT,
    name VARCHAR(250),
    value_as_string VARCHAR(250),
    value_as_concept_id INT,
    value_as_number FLOAT,
    metadata_date DATE,
    metadata_datetime TIMESTAMP
  ),
  column_descriptions (
    metadata_id = 'A unique identifier for each metadata record.',
    metadata_concept_id = 'A foreign key identifier to the Concept defining the metadata item.',
    metadata_type_concept_id = 'A foreign key identifier to the Concept defining the type of metadata.',
    name = 'The name of the metadata item.',
    value_as_string = 'The string value of the metadata item.',
    value_as_concept_id = 'A foreign key identifier to a Concept representing the value.',
    value_as_number = 'The numeric value of the metadata item.',
    metadata_date = 'The date associated with the metadata item.',
    metadata_datetime = 'The date and time associated with the metadata item.'
  )
);

-- Note: This model is typically populated manually or by specific ETL processes,
-- not directly from raw Synthea data in this basic ETL.
-- Creating an empty table structure for compatibility.
SELECT
    CAST(NULL AS BIGINT) AS metadata_id,
    CAST(NULL AS INT) AS metadata_concept_id,
    CAST(NULL AS INT) AS metadata_type_concept_id,
    CAST(NULL AS VARCHAR(250)) AS name,
    CAST(NULL AS VARCHAR(250)) AS value_as_string,
    CAST(NULL AS INT) AS value_as_concept_id,
    CAST(NULL AS FLOAT) AS value_as_number,
    CAST(NULL AS DATE) AS metadata_date,
    CAST(NULL AS TIMESTAMP) AS metadata_datetime
WHERE 1 = 0