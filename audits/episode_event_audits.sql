AUDIT (
  name episode_event_episode_event_field_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE_EVENT
WHERE
  EPISODE_EVENT_FIELD_CONCEPT_ID IS NULL;

AUDIT (
  name episode_event_episode_event_field_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.EPISODE_EVENT AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.EPISODE_EVENT_FIELD_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.EPISODE_EVENT_FIELD_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name episode_event_episode_event_field_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE_EVENT AS t
JOIN omop.concept AS c
  ON t.EPISODE_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Metadata';

AUDIT (
  name episode_event_episode_event_field_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE_EVENT AS t
LEFT JOIN omop.concept AS c
  ON t.EPISODE_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE
  NOT t.EPISODE_EVENT_FIELD_CONCEPT_ID IS NULL
  AND t.EPISODE_EVENT_FIELD_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name episode_event_episode_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE_EVENT
WHERE
  EPISODE_ID IS NULL;

AUDIT (
  name episode_event_episode_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.EPISODE_EVENT AS c
LEFT JOIN omop.EPISODE AS p
  ON c.EPISODE_ID = p.EPISODE_ID
WHERE
  NOT c.EPISODE_ID IS NULL AND p.EPISODE_ID IS NULL;

AUDIT (
  name episode_event_event_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE_EVENT
WHERE
  EVENT_ID IS NULL