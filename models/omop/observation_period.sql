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
  ),
  audits (
    observation_period_exists,
    person_completeness_observation_period,
    observation_period_observation_period_end_date_is_required,
    observation_period_observation_period_end_date_after_birth,
    observation_period_observation_period_id_is_required,
    observation_period_observation_period_id_is_primary_key,
    observation_period_observation_period_start_date_is_required,
    observation_period_observation_period_start_date_start_before_end,
    observation_period_observation_period_start_date_after_birth,
    observation_period_period_type_concept_id_is_required,
    observation_period_period_type_concept_id_is_foreign_key,
    observation_period_period_type_concept_id_fk_domain,
    observation_period_period_type_concept_id_is_standard_valid_concept,
    observation_period_period_type_concept_id_standard_concept_record_completeness,
    observation_period_person_id_is_required,
    observation_period_person_id_is_foreign_key
  )
);

WITH tmp AS (
    SELECT
      person_id,
      MIN(visit_detail_start_date) AS observation_period_start_date,
      MAX(visit_detail_end_date) AS observation_period_end_date
    FROM int.visit_detail
    GROUP BY
      person_id
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id) AS observation_period_id,
  person_id,
  observation_period_start_date,
  observation_period_end_date,
  32882 AS period_type_concept_id
FROM tmp