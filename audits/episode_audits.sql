AUDIT (
  name episode_episode_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE
WHERE
  EPISODE_CONCEPT_ID IS NULL;

AUDIT (
  name episode_episode_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.EPISODE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.EPISODE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.EPISODE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name episode_episode_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE AS t
JOIN omop.concept AS c
  ON t.EPISODE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Episode';

AUDIT (
  name episode_episode_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE AS t
LEFT JOIN omop.concept AS c
  ON t.EPISODE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.EPISODE_CONCEPT_ID IS NULL
  AND t.EPISODE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name episode_episode_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE
WHERE
  EPISODE_CONCEPT_ID = 0;

AUDIT (
  name episode_episode_end_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.EPISODE_END_DATE < p.birth_datetime;

AUDIT (
  name episode_episode_end_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.EPISODE_END_DATETIME < p.birth_datetime;

AUDIT (
  name episode_episode_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE
WHERE
  EPISODE_ID IS NULL;

AUDIT (
  name episode_episode_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  EPISODE_ID,
  COUNT(*)
FROM omop.EPISODE
WHERE
  NOT EPISODE_ID IS NULL
GROUP BY
  EPISODE_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name episode_episode_object_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE
WHERE
  EPISODE_OBJECT_CONCEPT_ID IS NULL;

AUDIT (
  name episode_episode_object_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.EPISODE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.EPISODE_OBJECT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.EPISODE_OBJECT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name episode_episode_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.EPISODE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.EPISODE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.EPISODE_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name episode_episode_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE
WHERE
  EPISODE_START_DATE IS NULL;

AUDIT (
  name episode_episode_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE
WHERE
  EPISODE_START_DATE > EPISODE_END_DATE;

AUDIT (
  name episode_episode_start_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.EPISODE_START_DATE < p.birth_datetime;

AUDIT (
  name episode_episode_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE
WHERE
  EPISODE_START_DATETIME > EPISODE_END_DATETIME;

AUDIT (
  name episode_episode_start_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.EPISODE_START_DATETIME < p.birth_datetime;

AUDIT (
  name episode_episode_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE
WHERE
  EPISODE_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name episode_episode_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.EPISODE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.EPISODE_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.EPISODE_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name episode_episode_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE AS t
JOIN omop.concept AS c
  ON t.EPISODE_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name episode_episode_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.EPISODE AS t
LEFT JOIN omop.concept AS c
  ON t.EPISODE_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.EPISODE_TYPE_CONCEPT_ID IS NULL
  AND t.EPISODE_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name episode_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.EPISODE
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name episode_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.EPISODE AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL