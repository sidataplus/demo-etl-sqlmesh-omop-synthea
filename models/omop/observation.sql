MODEL (
  name omop.observation,
  kind FULL,
  description 'OMOP Observation table capturing clinical facts about a Person.',
  columns (
    observation_id BIGINT,
    person_id BIGINT,
    observation_concept_id INT,
    observation_date DATE,
    observation_datetime TIMESTAMP,
    observation_type_concept_id INT,
    value_as_number REAL,
    value_as_string TEXT,
    value_as_concept_id INT,
    qualifier_concept_id INT,
    unit_concept_id INT,
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    observation_source_value TEXT,
    observation_source_concept_id INT,
    unit_source_value TEXT,
    qualifier_source_value TEXT,
    value_source_value TEXT,
    observation_event_id BIGINT,
    obs_event_field_concept_id INT
  ),
  column_descriptions (observation_id = 'A unique identifier for each observation.', person_id = 'A foreign key identifier to the Person associated with the observation.', observation_concept_id = 'A foreign key to the standard Concept identifier for the observation.', observation_date = 'The date on which the observation was recorded.', observation_datetime = 'The date and time on which the observation was recorded.', observation_type_concept_id = 'A foreign key to the standard Concept identifier defining the type of observation.', value_as_number = 'The numeric value of the observation, if applicable.', value_as_string = 'The string value of the observation, if applicable.', value_as_concept_id = 'A foreign key to the standard Concept identifier representing the observation value.', qualifier_concept_id = 'A foreign key to the standard Concept identifier for the qualifier.', unit_concept_id = 'A foreign key to the standard Concept identifier for the unit.', provider_id = 'A foreign key identifier to the Provider associated with the observation.', visit_occurrence_id = 'A foreign key identifier to the Visit Occurrence during which the observation was recorded.', visit_detail_id = 'A foreign key identifier to the Visit Detail during which the observation was recorded.', observation_source_value = 'The source code for the observation.', observation_source_concept_id = 'A foreign key to the source Concept identifier for the observation.', unit_source_value = 'The source code for the unit.', qualifier_source_value = 'The source code for the qualifier.', value_source_value = 'The source code for the observation value.', observation_event_id = 'The primary key of a linked event record.', obs_event_field_concept_id = 'A foreign key to the Concept identifier for the linked event table.')
);

WITH all_observations AS (
  SELECT
    *
  FROM int.observation_allergies
  UNION ALL
  SELECT
    *
  FROM int.observation_conditions
  UNION ALL
  SELECT
    *
  FROM int.observation_observations
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id) AS observation_id,
  person_id::BIGINT,
  observation_concept_id::INT,
  observation_date::DATE,
  observation_datetime::TIMESTAMP,
  observation_type_concept_id::INT,
  NULL::REAL AS value_as_number, /* dbt model casts null */
  NULL::TEXT AS value_as_string, /* dbt model casts null */
  0::INT AS value_as_concept_id, /* dbt model hardcodes 0 */
  0::INT AS qualifier_concept_id, /* dbt model hardcodes 0 */
  0::INT AS unit_concept_id, /* dbt model hardcodes 0 */
  provider_id::BIGINT,
  visit_occurrence_id::BIGINT,
  visit_detail_id::BIGINT,
  observation_source_value::TEXT,
  observation_source_concept_id::INT,
  NULL::TEXT AS unit_source_value, /* dbt model casts null */
  NULL::TEXT AS qualifier_source_value, /* dbt model casts null */
  NULL::TEXT AS value_source_value, /* dbt model casts null */
  NULL::BIGINT AS observation_event_id, /* dbt model casts null */
  NULL::INT AS obs_event_field_concept_id /* dbt model casts null */
FROM all_observations