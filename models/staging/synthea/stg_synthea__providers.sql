MODEL (
    name stg.synthea__providers,
    description "Synthea providers table",
    kind VIEW,
    columns (
        provider_id varchar,
        organization_id varchar,
        provider_name varchar,
        provider_gender varchar,
        provider_specialty varchar,
        provider_address varchar,
        provider_city varchar,
        provider_state varchar,
        provider_zip varchar,
        provider_latitude double,
        provider_longitude double,
        provider_utilization int
    ),
    column_descriptions (
        provider_id = 'Unique identifier for the provider.',
        organization_id = 'The organization ID the provider belongs to.',
        provider_name = 'Name of the provider.',
        provider_gender = 'Gender of the provider.',
        provider_specialty = 'Specialty of the provider.',
        provider_address = 'Address of the provider.',
        provider_city = 'City of the provider.',
        provider_state = 'State of the provider.',
        provider_zip = 'ZIP code of the provider.',
        provider_latitude = 'Latitude of the provider.',
        provider_longitude = 'Longitude of the provider.',
        provider_utilization = 'The number of Encounters performed by this Provider.'
    )
);

SELECT
    ID as provider_id,
    ORGANIZATION as organization_id,
    NAME as provider_name,
    GENDER as provider_gender,
    SPECIALITY as provider_specialty,
    ADDRESS as provider_address,
    CITY as provider_city,
    STATE as provider_state,
    ZIP as provider_zip,
    LAT as provider_latitude,
    LON as provider_longitude,
    UTILIZATION as provider_utilization
FROM synthea.providers;
