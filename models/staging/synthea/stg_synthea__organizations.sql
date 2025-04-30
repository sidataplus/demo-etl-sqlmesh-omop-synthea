MODEL (
    name stg.synthea__organizations,
    description "Synthea organizations table",
    kind VIEW,
    columns (
        organization_id varchar,
        organization_name varchar,
        organization_address varchar,
        organization_city varchar,
        organization_state varchar,
        organization_zip varchar,
        organization_latitude double,
        organization_longitude double,
        organization_phone varchar,
        organization_revenue double,
        organization_utilization int
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
    ID as organization_id,
    NAME as organization_name,
    ADDRESS as organization_address,
    CITY as organization_city,
    STATE as organization_state,
    ZIP as organization_zip,
    LAT as organization_latitude,
    LON as organization_longitude,
    PHONE as organization_phone,
    REVENUE as organization_revenue,
    UTILIZATION as organization_utilization
FROM synthea.organizations;
