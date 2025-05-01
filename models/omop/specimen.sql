MODEL (
  name omop.specimen,
  kind FULL,
  description 'OMOP Specimen table - Currently empty as per source dbt model.',
  columns (
    specimen_id BIGINT,
    person_id BIGINT,
    specimen_concept_id INTEGER,
    specimen_type_concept_id INTEGER,
    specimen_date DATE,
    specimen_datetime TIMESTAMP,
    quantity DECIMAL,
    unit_concept_id INTEGER,
    anatomic_site_concept_id INTEGER,
    disease_status_concept_id INTEGER,
    specimen_source_id VARCHAR(50),
    specimen_source_value VARCHAR(50),
    unit_source_value VARCHAR(50),
    anatomic_site_source_value VARCHAR(50),
    disease_status_source_value VARCHAR(50)
  ),
  column_descriptions (
    specimen_id = 'A unique identifier for each specimen.',
    person_id = 'A foreign key identifier to the Person associated with the specimen.',
    specimen_concept_id = 'A foreign key to the standard Concept identifier in the Standardized Vocabularies for the specimen.',
    specimen_type_concept_id = 'A foreign key to the standard Concept identifier in the Standardized Vocabularies defining the type of specimen.',
    specimen_date = 'The date on which the specimen was collected.',
    specimen_datetime = 'The date and time on which the specimen was collected.',
    quantity = 'The quantity or amount of the specimen collected.',
    unit_concept_id = 'A foreign key to the standard Concept identifier in the Standardized Vocabularies for the unit of the specimen quantity.',
    anatomic_site_concept_id = 'A foreign key to the standard Concept identifier in the Standardized Vocabularies for the anatomic site from which the specimen was collected.',
    disease_status_concept_id = 'A foreign key to the standard Concept identifier in the Standardized Vocabularies for the disease status associated with the specimen.',
    specimen_source_id = 'An identifier for the source specimen.',
    specimen_source_value = 'The source code for the specimen as it appears in the source data.',
    unit_source_value = 'The source code for the unit of the specimen quantity.',
    anatomic_site_source_value = 'The source code for the anatomic site from which the specimen was collected.',
    disease_status_source_value = 'The source code for the disease status associated with the specimen.'
  ),
  dialect 'duckdb'
);

SELECT
    CAST(NULL AS BIGINT) AS specimen_id,
    CAST(NULL AS BIGINT) AS person_id,
    CAST(NULL AS INTEGER) AS specimen_concept_id,
    CAST(NULL AS INTEGER) AS specimen_type_concept_id,
    CAST(NULL AS DATE) AS specimen_date,
    CAST(NULL AS TIMESTAMP) AS specimen_datetime,
    CAST(NULL AS DECIMAL) AS quantity,
    CAST(NULL AS INTEGER) AS unit_concept_id,
    CAST(NULL AS INTEGER) AS anatomic_site_concept_id,
    CAST(NULL AS INTEGER) AS disease_status_concept_id,
    CAST(NULL AS VARCHAR(50)) AS specimen_source_id,
    CAST(NULL AS VARCHAR(50)) AS specimen_source_value,
    CAST(NULL AS VARCHAR(50)) AS unit_source_value,
    CAST(NULL AS VARCHAR(50)) AS anatomic_site_source_value,
    CAST(NULL AS VARCHAR(50)) AS disease_status_source_value
WHERE 1 = 0;