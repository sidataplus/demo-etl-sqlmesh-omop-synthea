AUDIT (
  name domain_domain_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOMAIN
WHERE
  DOMAIN_CONCEPT_ID IS NULL;

AUDIT (
  name domain_domain_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DOMAIN AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DOMAIN_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DOMAIN_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name domain_domain_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOMAIN
WHERE
  DOMAIN_ID IS NULL;

AUDIT (
  name domain_domain_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  DOMAIN_ID,
  COUNT(*)
FROM omop.DOMAIN
WHERE
  NOT DOMAIN_ID IS NULL
GROUP BY
  DOMAIN_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name domain_domain_name_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DOMAIN
WHERE
  DOMAIN_NAME IS NULL