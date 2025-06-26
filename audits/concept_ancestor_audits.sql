AUDIT (
  name concept_ancestor_ancestor_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_ANCESTOR
WHERE
  ANCESTOR_CONCEPT_ID IS NULL;

AUDIT (
  name concept_ancestor_ancestor_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT_ANCESTOR AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.ANCESTOR_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.ANCESTOR_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name concept_ancestor_descendant_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_ANCESTOR
WHERE
  DESCENDANT_CONCEPT_ID IS NULL;

AUDIT (
  name concept_ancestor_descendant_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT_ANCESTOR AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DESCENDANT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DESCENDANT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name concept_ancestor_max_levels_of_separation_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_ANCESTOR
WHERE
  MAX_LEVELS_OF_SEPARATION IS NULL;

AUDIT (
  name concept_ancestor_min_levels_of_separation_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_ANCESTOR
WHERE
  MIN_LEVELS_OF_SEPARATION IS NULL