AUDIT (
  name concept_relationship_concept_id_1_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_RELATIONSHIP
WHERE
  CONCEPT_ID_1 IS NULL;

AUDIT (
  name concept_relationship_concept_id_1_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT_RELATIONSHIP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.CONCEPT_ID_1 = p.CONCEPT_ID
WHERE
  NOT c.CONCEPT_ID_1 IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name concept_relationship_concept_id_2_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_RELATIONSHIP
WHERE
  CONCEPT_ID_2 IS NULL;

AUDIT (
  name concept_relationship_concept_id_2_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT_RELATIONSHIP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.CONCEPT_ID_2 = p.CONCEPT_ID
WHERE
  NOT c.CONCEPT_ID_2 IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name concept_relationship_relationship_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_RELATIONSHIP
WHERE
  RELATIONSHIP_ID IS NULL;

AUDIT (
  name concept_relationship_relationship_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT_RELATIONSHIP AS c
LEFT JOIN omop.RELATIONSHIP AS p
  ON c.RELATIONSHIP_ID = p.RELATIONSHIP_ID
WHERE
  NOT c.RELATIONSHIP_ID IS NULL AND p.RELATIONSHIP_ID IS NULL;

AUDIT (
  name concept_relationship_valid_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_RELATIONSHIP
WHERE
  VALID_END_DATE IS NULL;

AUDIT (
  name concept_relationship_valid_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_RELATIONSHIP
WHERE
  VALID_START_DATE IS NULL;

AUDIT (
  name concept_relationship_valid_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_RELATIONSHIP
WHERE
  VALID_START_DATE > VALID_END_DATE