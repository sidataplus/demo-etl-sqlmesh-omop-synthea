MODEL (
  name omop.observation_period,
  kind FULL,
  description "Defines spans of time during which clinical events are recorded for a Person.",
  columns (
    observation_period_id BIGINT,
    person_id BIGINT,
    observation_period_start_date DATE,
    observation_period_end_date DATE,
    period_type_concept_id INT
  ),
  column_descriptions (
    observation_period_id = 'A unique identifier for each observation period.',
    person_id = 'A foreign key identifier to the Person associated with the observation period.',
    observation_period_start_date = 'The start date of the observation period.',
    observation_period_end_date = 'The end date of the observation period.',
    period_type_concept_id = 'A foreign key identifier to the Concept defining the type of observation period.'
  )
);


WITH tmp AS (
	SELECT
		person_id
		, min(visit_detail_start_date) AS observation_period_start_date
		, max(visit_detail_end_date) AS observation_period_end_date
	FROM int.visit_detail
	GROUP BY person_id
) 

SELECT 
	row_number() OVER (ORDER BY person_id) AS observation_period_id
	, person_id
	, observation_period_start_date
	, observation_period_end_date
	, 32882 AS period_type_concept_id
FROM tmp