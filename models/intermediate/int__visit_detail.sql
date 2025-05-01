MODEL (
    name int.visit_detail,
    description "Intermediate visit detail model, linking encounters to visits",
    kind FULL,
    columns (
        visit_detail_id BIGINT,
        encounter_id VARCHAR,
        person_id BIGINT,
        visit_detail_concept_id INT,
        visit_detail_start_date DATE,
        visit_detail_start_datetime TIMESTAMP,
        visit_detail_end_date DATE,
        visit_detail_end_datetime TIMESTAMP,
        visit_detail_type_concept_id INT,
        provider_id BIGINT,
        care_site_id INT,
        admitted_from_concept_id INT,
        discharged_to_concept_id INT,
        preceding_visit_detail_id INT,
        visit_detail_source_value VARCHAR,
        visit_detail_source_concept_id INT,
        admitted_from_source_value VARCHAR,
        discharged_to_source_value VARCHAR,
        parent_visit_detail_id INT,
        visit_occurrence_id BIGINT,
        total_encounter_cost NUMERIC,
        encounter_payer_coverage NUMERIC
    )
);

JINJA_QUERY_BEGIN;

SELECT
    row_number() OVER (ORDER BY e.encounter_id) AS visit_detail_id
    , e.encounter_id
    , e.person_id
    , CASE
        WHEN lower(e.encounter_class) IN ('ambulatory', 'wellness', 'outpatient') THEN 9202 -- Outpatient Visit
        WHEN lower(e.encounter_class) IN ('emergency', 'urgentcare') THEN 9203 -- Emergency Room Visit
        WHEN lower(e.encounter_class) = 'inpatient' THEN 9201 -- Inpatient Visit
        ELSE 0
    END AS visit_detail_concept_id
    , e.encounter_start_date AS visit_detail_start_date
    , e.encounter_start_datetime AS visit_detail_start_datetime
    , e.encounter_stop_date AS visit_detail_end_date
    , e.encounter_stop_datetime AS visit_detail_end_datetime
    , 32827 AS visit_detail_type_concept_id -- EHR Encounter Record
    , e.provider_id
    , CAST(NULL AS INT)  AS care_site_id
    , 0 AS admitted_from_concept_id
    , 0 AS discharged_to_concept_id
    , CAST(NULL AS INT) AS preceding_visit_detail_id
    , e.encounter_class AS visit_detail_source_value
    , 0 AS visit_detail_source_concept_id
    , CAST(NULL AS VARCHAR) AS admitted_from_source_value
    , CAST(NULL AS VARCHAR) AS discharged_to_source_value
    , CAST(NULL AS INT)  AS parent_visit_detail_id
    , v.visit_occurrence_id
    , e.total_encounter_cost
    , e.encounter_payer_coverage
FROM int.visits_encounters AS ve
INNER JOIN int.visits AS v
    ON ve.visit_id = v.visit_id
INNER JOIN int.encounters AS e
    ON ve.encounter_id = e.encounter_id

JINJA_END;
