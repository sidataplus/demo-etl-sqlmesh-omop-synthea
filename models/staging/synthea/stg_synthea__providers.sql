MODEL (
  name stg.synthea__providers,
  description "Synthea providers table",
  kind VIEW,
  columns (
    provider_id TEXT,
    organization_id TEXT,
    provider_name TEXT,
    provider_gender TEXT,
    provider_specialty TEXT,
    provider_address TEXT,
    provider_city TEXT,
    provider_state TEXT,
    provider_zip TEXT,
    provider_latitude DOUBLE,
    provider_longitude DOUBLE,
    provider_utilization INT
  ),
  column_descriptions (provider_id = 'Unique identifier for the provider.', organization_id = 'The organization ID the provider belongs to.', provider_name = 'Name of the provider.', provider_gender = 'Gender of the provider.', provider_specialty = 'Specialty of the provider.', provider_address = 'Address of the provider.', provider_city = 'City of the provider.', provider_state = 'State of the provider.', provider_zip = 'ZIP code of the provider.', provider_latitude = 'Latitude of the provider.', provider_longitude = 'Longitude of the provider.', provider_utilization = 'The number of Encounters performed by this Provider.')
);

SELECT
  ID AS provider_id,
  ORGANIZATION AS organization_id,
  NAME AS provider_name,
  GENDER AS provider_gender,
  SPECIALITY AS provider_specialty,
  ADDRESS AS provider_address,
  CITY AS provider_city,
  STATE AS provider_state,
  ZIP AS provider_zip,
  LAT AS provider_latitude,
  LON AS provider_longitude,
  UTILIZATION AS provider_utilization
FROM synthea.providers