MODEL (
  name omop.cdm_source,
  kind FULL,
  description "The CDM_SOURCE table contains detail about the source database and the process used to transform the data into the OMOP Common Data Model.",
  columns (
    cdm_source_name VARCHAR(255),
    cdm_source_abbreviation VARCHAR(25),
    cdm_holder VARCHAR(255),
    source_description VARCHAR,
    source_documentation_reference VARCHAR(255),
    cdm_etl_reference VARCHAR(255),
    source_release_date DATE,
    cdm_release_date DATE,
    cdm_version VARCHAR(10),
    vocabulary_version VARCHAR(20),
    cdm_version_concept_id INT
  ),
  column_descriptions (
    cdm_source_name = 'The name of the CDM instance.',
    cdm_source_abbreviation = 'The abbreviation of the CDM instance.',
    cdm_holder = 'The holder of the CDM instance.',
    source_description = 'The description of the CDM instance.',
    source_documentation_reference = 'Reference to documentation about the source data.',
    cdm_etl_reference = 'Reference to the ETL process.',
    source_release_date = 'The date the data was extracted from the source system.',
    cdm_release_date = 'The date the ETL script was completed.',
    cdm_version = 'Version of the OMOP CDM used as string. e.g. v5.4',
    vocabulary_version = 'Version of the OMOP standardised vocabularies loaded',
    cdm_version_concept_id = 'The Concept Id representing the version of the CDM.'
  )
);

SELECT
    'sqlmesh-synthea' AS cdm_source_name,
    'sqlmesh-synthea' AS cdm_source_abbreviation,
    'OHDSI' AS cdm_holder,
    'An OMOP CDM derived from a Synthea dataset using SQLMesh.' AS source_description,
    'https://synthetichealth.github.io/synthea/' AS source_documentation_reference,
    'https://github.com/TobiasMann/sqlmesh-synthea' AS cdm_etl_reference, -- Placeholder, update if needed
    current_date AS source_release_date,
    current_date AS cdm_release_date,
    '5.4' AS cdm_version,
    vocabulary_version::VARCHAR(20),
    798878 AS cdm_version_concept_id -- Concept ID for CDM v5.4
FROM stg.vocabulary__vocabulary
WHERE vocabulary_id = 'None'