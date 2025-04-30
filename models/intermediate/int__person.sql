MODEL (
    name int.person,
    description "Intermediate person model with mapped concept IDs and location ID",
    kind FULL,
    columns (
        person_id BIGINT,
        gender_concept_id INT,
        year_of_birth INT,
        month_of_birth INT,
        day_of_birth INT,
        birth_datetime TIMESTAMP,
        race_concept_id INT,
        ethnicity_concept_id INT,
        location_id INT,
        provider_id INT,
        care_site_id INT,
        person_source_value VARCHAR,
        gender_source_value VARCHAR,
        gender_source_concept_id INT,
        race_source_value VARCHAR,
        race_source_concept_id INT,
        ethnicity_source_value VARCHAR,
        ethnicity_source_concept_id INT
    )
);

JINJA_QUERY_BEGIN;

{% set address_columns = [
    "p.patient_address",
    "p.patient_city",
    "s.state_abbreviation",
    "p.patient_zip",
    "p.patient_county"
] %}

SELECT
    row_number() OVER (ORDER BY p.patient_id) AS person_id
    , CASE
        WHEN upper(p.patient_gender) = 'M' THEN 8507
        WHEN upper(p.patient_gender) = 'F' THEN 8532
        ELSE 0
    END AS gender_concept_id
    , extract(YEAR FROM p.birth_date) AS year_of_birth
    , extract(MONTH FROM p.birth_date) AS month_of_birth
    , extract(DAY FROM p.birth_date) AS day_of_birth
    , CAST(NULL AS TIMESTAMP) AS birth_datetime
    , CASE
        WHEN upper(p.race) = 'WHITE' THEN 8527
        WHEN upper(p.race) = 'BLACK' THEN 8516
        WHEN upper(p.race) = 'ASIAN' THEN 8515
        ELSE 0
    END AS race_concept_id
    , CASE
        WHEN upper(p.ethnicity) = 'HISPANIC' THEN 38003563
        WHEN upper(p.ethnicity) = 'NONHISPANIC' THEN 38003564
        ELSE 0
    END AS ethnicity_concept_id
    , loc.location_id
    , CAST(NULL AS INT)  AS provider_id
    , CAST(NULL AS INT)  AS care_site_id
    , p.patient_id AS person_source_value
    , p.patient_gender AS gender_source_value
    , 0 AS gender_source_concept_id
    , p.race AS race_source_value
    , 0 AS race_source_concept_id
    , p.ethnicity AS ethnicity_source_value
    , 0 AS ethnicity_source_concept_id
FROM stg.synthea__patients AS p
LEFT JOIN stg.map__states AS s ON p.patient_state = s.state_name
LEFT JOIN int.location AS loc
    ON loc.location_source_value = {{ safe_hash(address_columns) }}

JINJA_END;
