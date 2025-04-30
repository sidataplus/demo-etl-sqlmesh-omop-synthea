MODEL (
    name int.op_visits,
    description "Intermediate model for single-day outpatient visits",
    kind FULL,
    columns (
        visit_id VARCHAR,
        encounter_id VARCHAR,
        person_id BIGINT,
        visit_class VARCHAR,
        visit_start_date DATE,
        visit_end_date DATE
    )
);

JINJA_QUERY_BEGIN;
/* outpatient visits */

SELECT
    encounter_id AS visit_id
    , encounter_id
    , person_id
    , encounter_class AS visit_class
    , encounter_start_date AS visit_start_date
    , encounter_stop_date AS visit_end_date
FROM int.encounters
WHERE encounter_class IN ('ambulatory', 'wellness', 'outpatient')
-- only include single-day visits
AND encounter_start_date = encounter_stop_date

JINJA_END;
