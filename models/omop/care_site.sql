MODEL (
  name omop.care_site,
  kind FULL,
  description "The CARE_SITE table contains a list of uniquely identified institutional (physical) locations where healthcare is delivered. Care Sites are specific physical locations or organizations. Examples include hospitals, clinics, and diagnostic centers.",
  columns (
    care_site_id INT,
    care_site_name TEXT,
    place_of_service_concept_id INT,
    location_id INT,
    care_site_source_value TEXT,
    place_of_service_source_value TEXT
  ),
  column_descriptions (care_site_id = 'A unique identifier for each Care Site.', care_site_name = 'The verbatim name of the Care Site, as specified in the source data.', place_of_service_concept_id = 'A foreign key to the Place of Service Concept in the StandardizedVocabularies.', location_id = 'A foreign key to the location table.', care_site_source_value = 'The identifier for the Care Site in the source data.', place_of_service_source_value = 'The Place of Service identifier, as it appears in the source data.')
);

JINJA_QUERY_BEGIN;
{% set address_columns = [
    "org.organization_address",
    "org.organization_city",
    "org.organization_state",
    "org.organization_zip",
] %}

SELECT
    ROW_NUMBER() OVER (ORDER BY org.organization_id) AS care_site_id,
    org.organization_name AS care_site_name,
    0 AS place_of_service_concept_id,
    loc.location_id,
    org.organization_id AS care_site_source_value,
    CAST(NULL AS VARCHAR) AS place_of_service_source_value
FROM stg.synthea__organizations AS org -- Reference staging model
LEFT JOIN omop.location AS loc -- Reference omop model
    ON loc.location_source_value = {{ safe_hash(address_columns) }} -- Use Jinja macro call
JINJA_END;