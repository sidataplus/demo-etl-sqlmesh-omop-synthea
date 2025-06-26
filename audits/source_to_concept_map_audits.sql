AUDIT (
  name source_to_concept_map_source_code_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SOURCE_TO_CONCEPT_MAP
WHERE
  SOURCE_CODE IS NULL;

AUDIT (
  name source_to_concept_map_source_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SOURCE_TO_CONCEPT_MAP
WHERE
  SOURCE_CONCEPT_ID IS NULL;

AUDIT (
  name source_to_concept_map_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.SOURCE_TO_CONCEPT_MAP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name source_to_concept_map_source_vocabulary_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SOURCE_TO_CONCEPT_MAP
WHERE
  SOURCE_VOCABULARY_ID IS NULL;

AUDIT (
  name source_to_concept_map_target_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SOURCE_TO_CONCEPT_MAP
WHERE
  TARGET_CONCEPT_ID IS NULL;

AUDIT (
  name source_to_concept_map_target_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.SOURCE_TO_CONCEPT_MAP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.TARGET_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.TARGET_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name source_to_concept_map_target_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.SOURCE_TO_CONCEPT_MAP AS t
LEFT JOIN omop.concept AS c
  ON t.TARGET_CONCEPT_ID = c.concept_id
WHERE
  NOT t.TARGET_CONCEPT_ID IS NULL
  AND t.TARGET_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name source_to_concept_map_target_vocabulary_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SOURCE_TO_CONCEPT_MAP
WHERE
  TARGET_VOCABULARY_ID IS NULL;

AUDIT (
  name source_to_concept_map_target_vocabulary_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.SOURCE_TO_CONCEPT_MAP AS c
LEFT JOIN omop.VOCABULARY AS p
  ON c.TARGET_VOCABULARY_ID = p.VOCABULARY_ID
WHERE
  NOT c.TARGET_VOCABULARY_ID IS NULL AND p.VOCABULARY_ID IS NULL;

AUDIT (
  name source_to_concept_map_valid_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SOURCE_TO_CONCEPT_MAP
WHERE
  VALID_END_DATE IS NULL;

AUDIT (
  name source_to_concept_map_valid_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SOURCE_TO_CONCEPT_MAP
WHERE
  VALID_START_DATE IS NULL;

AUDIT (
  name source_to_concept_map_valid_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SOURCE_TO_CONCEPT_MAP
WHERE
  VALID_START_DATE > VALID_END_DATE