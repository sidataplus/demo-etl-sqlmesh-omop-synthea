MODEL (
  name int.location,
  description "Location table",
  kind FULL,
  columns (
    location_id INT,
    address_1 TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    county TEXT,
    location_source_value TEXT
  )
);

JINJA_QUERY_BEGIN;
{% set address_columns = [
    "address_1", 
    "city",
    "state",
    "zip",
    "county"
] %}


WITH unioned_location_sources AS (
	SELECT DISTINCT
		p.patient_address AS address_1
		, p.patient_city AS city
		, s.state_abbreviation AS state
		, p.patient_zip AS zip
		, p.patient_county AS county
	FROM stg.synthea__patients AS p
	LEFT JOIN stg.map__states AS s ON p.patient_state = s.state_name

	UNION

	SELECT DISTINCT
		organization_address AS address_1
		, organization_city AS city
		, organization_state AS state
		, organization_zip AS zip
		, NULL::VARCHAR AS county
	FROM
		stg.synthea__organizations
)
SELECT
	row_number() OVER (ORDER BY state, city, address_1) AS location_id
	, address_1
	, city
	, state
	, zip
	, county
	, {{ safe_hash(address_columns) }} AS location_source_value
FROM unioned_location_sources
JINJA_END;