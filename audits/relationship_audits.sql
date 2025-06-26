AUDIT (
  name relationship_defines_ancestry_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.RELATIONSHIP
WHERE
  DEFINES_ANCESTRY IS NULL;

AUDIT (
  name relationship_is_hierarchical_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.RELATIONSHIP
WHERE
  IS_HIERARCHICAL IS NULL;

AUDIT (
  name relationship_relationship_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.RELATIONSHIP
WHERE
  RELATIONSHIP_CONCEPT_ID IS NULL;

AUDIT (
  name relationship_relationship_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.RELATIONSHIP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.RELATIONSHIP_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.RELATIONSHIP_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name relationship_relationship_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.RELATIONSHIP
WHERE
  RELATIONSHIP_ID IS NULL;

AUDIT (
  name relationship_relationship_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  RELATIONSHIP_ID,
  COUNT(*)
FROM omop.RELATIONSHIP
WHERE
  NOT RELATIONSHIP_ID IS NULL
GROUP BY
  RELATIONSHIP_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name relationship_relationship_name_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.RELATIONSHIP
WHERE
  RELATIONSHIP_NAME IS NULL;

AUDIT (
  name relationship_reverse_relationship_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.RELATIONSHIP
WHERE
  REVERSE_RELATIONSHIP_ID IS NULL