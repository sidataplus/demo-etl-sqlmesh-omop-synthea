MODEL (
    name int.visits,
    description "Assigns a unique visit_occurrence_id to each distinct visit",
    kind FULL,
    columns (
        visit_occurrence_id BIGINT,
        visit_id VARCHAR, -- Changed from BIGINT to VARCHAR to accommodate different visit_id types
        person_id BIGINT,
        visit_class VARCHAR,
        visit_start_date DATE,
        visit_end_date DATE
    )
);

JINJA_QUERY_BEGIN;
/*
for IP visits, we rolled up many encounters into a single visit and assigned it a visit_id. for OP/ER visits, the visit_id is the same as the encounter_id as no roll-up occurred. in this model we assign an integer ID based on the rolled-up visit_id, to use as the visit_occurrence_id.
*/

WITH all_visits AS (
    SELECT
        visit_id
        , person_id
        , visit_class
        , visit_start_date
        , visit_end_date
    FROM int.visits_encounters
    WHERE visit_class IN ('outpatient', 'emergency', 'urgentcare', 'ambulatory', 'wellness')

    UNION ALL

    SELECT DISTINCT
        CAST(visit_id AS VARCHAR) -- Cast IP visit_id to VARCHAR for union compatibility
        , person_id
        , visit_class
        , visit_start_date
        , visit_end_date
    FROM int.visits_encounters
    WHERE visit_class IN ('inpatient', 'er+ip')
)

SELECT
    ROW_NUMBER() OVER (ORDER BY person_id, visit_start_date, visit_id) AS visit_occurrence_id
    , *
FROM all_visits

JINJA_END;
