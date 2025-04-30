MODEL (
    name int.visits_encounters,
    description "Union of all visit types (IP, ER, OP)",
    kind FULL,
    columns (
        visit_id VARCHAR, -- Changed from BIGINT to VARCHAR to accommodate different visit_id types
        encounter_id VARCHAR,
        person_id BIGINT,
        visit_class VARCHAR,
        visit_start_date DATE,
        visit_end_date DATE
    )
);

JINJA_QUERY_BEGIN;

SELECT CAST(visit_id AS VARCHAR), encounter_id, person_id, visit_class, visit_start_date, visit_end_date
FROM int.ip_visits

UNION ALL

SELECT visit_id, encounter_id, person_id, visit_class, visit_start_date, visit_end_date
FROM int.er_visits

UNION ALL

SELECT visit_id, encounter_id, person_id, visit_class, visit_start_date, visit_end_date
FROM int.op_visits

JINJA_END;
