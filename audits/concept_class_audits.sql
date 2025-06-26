AUDIT (
  name concept_class_concept_class_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_CLASS
WHERE
  CONCEPT_CLASS_CONCEPT_ID IS NULL;

AUDIT (
  name concept_class_concept_class_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CONCEPT_CLASS AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.CONCEPT_CLASS_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.CONCEPT_CLASS_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name concept_class_concept_class_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_CLASS
WHERE
  CONCEPT_CLASS_ID IS NULL;

AUDIT (
  name concept_class_concept_class_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  CONCEPT_CLASS_ID,
  COUNT(*)
FROM omop.CONCEPT_CLASS
WHERE
  NOT CONCEPT_CLASS_ID IS NULL
GROUP BY
  CONCEPT_CLASS_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name concept_class_concept_class_name_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CONCEPT_CLASS
WHERE
  CONCEPT_CLASS_NAME IS NULL