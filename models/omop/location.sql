MODEL (
  name omop.location,
  kind FULL,
  description "The LOCATION table represents a generic way to capture physical location or address information.",
  columns (
    location_id BIGINT,
    address_1 TEXT,
    address_2 TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    county TEXT,
    location_source_value TEXT,
    country_concept_id INT,
    country_source_value TEXT,
    latitude REAL,
    longitude REAL
  ),
  column_descriptions (
    location_id = 'A unique identifier for each location.',
    address_1 = 'The first line of the street address.',
    address_2 = 'The second line of the street address.',
    city = 'The city of the location.',
    state = 'The state or province of the location.',
    zip = 'The postal code of the location.',
    county = 'The county of the location.',
    location_source_value = 'The source identifier for the location.',
    country_concept_id = 'A foreign key to the Concept for the country.',
    country_source_value = 'The source value for the country.',
    latitude = 'The latitude of the location.',
    longitude = 'The longitude of the location.'
  ),
  audits (
    location_country_concept_id_is_foreign_key,
    location_country_concept_id_fk_domain,
    location_country_concept_id_is_standard_valid_concept,
    location_country_concept_id_standard_concept_record_completeness,
    location_location_id_is_required,
    location_location_id_is_primary_key
  )
);

SELECT
  location_id::BIGINT,
  address_1::TEXT,
  NULL::TEXT AS address_2,
  city::TEXT,
  state::TEXT,
  zip::TEXT,
  county::TEXT,
  location_source_value::TEXT,
  NULL::INT AS country_concept_id,
  NULL::TEXT AS country_source_value,
  NULL::REAL AS latitude,
  NULL::REAL AS longitude
FROM int.location