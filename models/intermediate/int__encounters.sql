MODEL (
    name int.encounters,
    description "Intermediate encounters model, joining staging encounters with person and provider IDs, removing duplicates",
    kind FULL,
    columns (
        encounter_id VARCHAR,
        encounter_start_datetime TIMESTAMP,
        encounter_start_date DATE,
        encounter_stop_datetime TIMESTAMP,
        encounter_stop_date DATE,
        person_id BIGINT,
        provider_id BIGINT,
        payer_id VARCHAR,
        encounter_class VARCHAR,
        encounter_code VARCHAR,
        encounter_description VARCHAR,
        base_encounter_cost NUMERIC,
        total_encounter_cost NUMERIC,
        encounter_payer_coverage NUMERIC,
        encounter_reason_code VARCHAR,
        encounter_reason_description VARCHAR
    )
);

JINJA_QUERY_BEGIN;

WITH cte_dupes AS (
    /*
    some encounter IDs are duplicated due to a bug in the Synthea data generation process.
    we flag duplicates here in order to remove them from downstream modesl, as there is no way to determine which encounter among duplicates is referenced by a foreign key to the encounters table.
    */
    SELECT encounter_id AS dupe_encounter_id
    FROM stg.synthea__encounters
    GROUP BY encounter_id
    HAVING COUNT(*) > 1
)

SELECT
    e.encounter_id
    , e.encounter_start_datetime
    , e.encounter_start_date
    , e.encounter_stop_datetime
    , e.encounter_stop_date
    , p.person_id
    , pr.provider_id
    , e.payer_id
    , e.encounter_class
    , e.encounter_code
    , e.encounter_description
    , e.base_encounter_cost
    , e.total_encounter_cost
    , e.encounter_payer_coverage
    , e.encounter_reason_code
    , e.encounter_reason_description
FROM stg.synthea__encounters AS e
LEFT JOIN cte_dupes
    ON e.encounter_id = cte_dupes.dupe_encounter_id
INNER JOIN int.person AS p
    ON e.patient_id = p.person_source_value
LEFT JOIN int.provider AS pr
    ON e.provider_id = pr.provider_source_value
WHERE cte_dupes.dupe_encounter_id IS NULL

JINJA_END;
