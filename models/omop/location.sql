MODEL (
  name omop.location,
  kind FULL,
  description "The LOCATION table represents a generic way to capture physical location or address information.",
  columns (
    location_id BIGINT,
    address_1 VARCHAR(50),
    address_2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(2),
    zip VARCHAR(9),
    county VARCHAR(20),
    location_source_value VARCHAR(50),
    country_concept_id INT,
    country_source_value VARCHAR(50),
    latitude FLOAT,
    longitude FLOAT
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
  )
);

SELECT
    location_id::BIGINT,
    address_1::VARCHAR(50),
    NULL::VARCHAR(50) AS address_2,
    city::VARCHAR(50),
    state::VARCHAR(2),
    zip::VARCHAR(9),
    county::VARCHAR(20),
    location_source_value::VARCHAR(50),
    NULL::INT AS country_concept_id,
    NULL::VARCHAR(50) AS country_source_value,
    NULL::FLOAT AS latitude,
    NULL::FLOAT AS longitude
FROM int.location;