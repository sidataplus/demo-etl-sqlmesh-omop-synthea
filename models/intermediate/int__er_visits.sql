MODEL (
  name int.er_visits,
  description "Intermediate model for single-day emergency/urgent care visits",
  kind FULL,
  columns (
    visit_id TEXT,
    encounter_id TEXT,
    person_id BIGINT,
    visit_class TEXT,
    visit_start_date DATE,
    visit_end_date DATE
  )
);

JINJA_QUERY_BEGIN;
/*
emergency visits
*/

SELECT
    encounter_id AS visit_id
    , encounter_id
    , person_id
    , encounter_class AS visit_class
    , encounter_start_date AS visit_start_date
    , encounter_stop_date AS visit_end_date
FROM int.encounters
WHERE encounter_class IN ('emergency', 'urgentcare')
-- only include single-day visits
AND encounter_start_date = encounter_stop_date
JINJA_END;