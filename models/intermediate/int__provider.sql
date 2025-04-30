MODEL (
    name int.provider,
    description "Intermediate provider model",
    kind FULL,
    columns (
        provider_id BIGINT,
        provider_name VARCHAR,
        npi VARCHAR(20),
        dea VARCHAR(20),
        specialty_concept_id INT,
        care_site_id INT,
        year_of_birth INT,
        gender_concept_id INT,
        provider_source_value VARCHAR,
        specialty_source_value VARCHAR,
        specialty_source_concept_id INT,
        gender_source_value VARCHAR,
        gender_source_concept_id INT
    )
);

JINJA_QUERY_BEGIN;

SELECT
    row_number() OVER (ORDER BY provider_state, provider_city, provider_zip, provider_id) AS provider_id
    , provider_name
    , CAST(null AS VARCHAR(20)) AS npi
    , CAST(null AS VARCHAR(20)) AS dea
    , 38004446 AS specialty_concept_id -- General Practice
    , CAST(null AS INT) AS care_site_id
    , CAST(null AS INT) AS year_of_birth
    , CASE upper(provider_gender)
        WHEN 'M' THEN 8507
        WHEN 'F' THEN 8532
    END AS gender_concept_id
    , provider_id AS provider_source_value
    , provider_specialty AS specialty_source_value
    , 38004446 AS specialty_source_concept_id -- General Practice
    , provider_gender AS gender_source_value
    , CASE upper(provider_gender)
        WHEN 'M' THEN 8507
        WHEN 'F' THEN 8532
    END AS gender_source_concept_id
FROM stg.synthea__providers

JINJA_END;
