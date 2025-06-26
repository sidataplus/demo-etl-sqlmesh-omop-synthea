AUDIT (
  name metadata_metadata_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.METADATA
WHERE
  METADATA_CONCEPT_ID IS NULL;

AUDIT (
  name metadata_metadata_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.METADATA AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.METADATA_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.METADATA_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name metadata_metadata_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.METADATA
WHERE
  METADATA_ID IS NULL;

AUDIT (
  name metadata_metadata_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  METADATA_ID,
  COUNT(*)
FROM omop.METADATA
WHERE
  NOT METADATA_ID IS NULL
GROUP BY
  METADATA_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name metadata_metadata_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.METADATA
WHERE
  METADATA_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name metadata_metadata_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.METADATA AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.METADATA_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.METADATA_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name metadata_name_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.METADATA
WHERE
  NAME IS NULL;

AUDIT (
  name metadata_value_as_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.METADATA AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VALUE_AS_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VALUE_AS_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL