MODEL (
  name stg.synthea__organizations,
  description "Synthea organizations table",
  kind VIEW,
  columns (
    organization_id TEXT,
    organization_name TEXT,
    organization_address TEXT,
    organization_city TEXT,
    organization_state TEXT,
    organization_zip TEXT,
    organization_latitude DOUBLE,
    organization_longitude DOUBLE,
    organization_phone TEXT,
    organization_revenue DOUBLE,
    organization_utilization INT
  ),
  column_descriptions (
    organization_id = 'Unique identifier for the organization.',
    organization_name = 'Name of the organization.',
    organization_address = 'Address of the organization.',
    organization_city = 'City of the organization.',
    organization_state = 'State of the organization.',
    organization_zip = 'ZIP code of the organization.',
    organization_latitude = 'Latitude of the organization.',
    organization_longitude = 'Longitude of the organization.',
    organization_phone = 'Phone number of the organization.',
    organization_revenue = 'The monetary revenue of the organization during the entire simulation.',
    organization_utilization = 'The number of Encounters performed by this Organization.'
  )
);

SELECT
  ID AS organization_id,
  NAME AS organization_name,
  ADDRESS AS organization_address,
  CITY AS organization_city,
  STATE AS organization_state,
  ZIP AS organization_zip,
  LAT AS organization_latitude,
  LON AS organization_longitude,
  PHONE AS organization_phone,
  REVENUE AS organization_revenue,
  UTILIZATION AS organization_utilization
FROM synthea.organizations