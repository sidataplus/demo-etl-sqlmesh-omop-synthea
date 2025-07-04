MODEL (
  name omop.episode_event,
  kind FULL,
  description "The EPISODE_EVENT table connects qualifying clinical events to the appropriate EPISODE entry.",
  columns (
    episode_id BIGINT,
    event_id BIGINT,
    episode_event_field_concept_id INT
  ),
  column_descriptions (
    episode_id = 'A foreign key identifier to the EPISODE table.',
    event_id = 'The primary key of the linked clinical event record (e.g., condition_occurrence_id).',
    episode_event_field_concept_id = 'A foreign key identifier to the Concept representing the table containing the linked event.'
  ),
  audits (
    episode_event_episode_event_field_concept_id_is_required,
    episode_event_episode_event_field_concept_id_is_foreign_key,
    episode_event_episode_event_field_concept_id_fk_domain,
    episode_event_episode_event_field_concept_id_is_standard_valid_concept,
    episode_event_episode_id_is_required,
    episode_event_episode_id_is_foreign_key,
    episode_event_event_id_is_required
  )
);

/* Note: This model is typically generated by OMOP-specific tools or derived datasets, */ /* not directly from raw Synthea data in this basic ETL. */ /* Creating an empty table structure for compatibility. */
SELECT
  NULL::BIGINT AS episode_id,
  NULL::BIGINT AS event_id,
  NULL::INT AS episode_event_field_concept_id
WHERE
  1 = 0