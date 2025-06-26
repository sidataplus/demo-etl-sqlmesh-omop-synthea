AUDIT (
  name fact_relationship_domain_concept_id_1_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.FACT_RELATIONSHIP
WHERE
  DOMAIN_CONCEPT_ID_1 IS NULL;

AUDIT (
  name fact_relationship_domain_concept_id_1_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.FACT_RELATIONSHIP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DOMAIN_CONCEPT_ID_1 = p.CONCEPT_ID
WHERE
  NOT c.DOMAIN_CONCEPT_ID_1 IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name fact_relationship_domain_concept_id_1_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.FACT_RELATIONSHIP
WHERE
  DOMAIN_CONCEPT_ID_1 = 0;

AUDIT (
  name fact_relationship_domain_concept_id_2_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.FACT_RELATIONSHIP
WHERE
  DOMAIN_CONCEPT_ID_2 IS NULL;

AUDIT (
  name fact_relationship_domain_concept_id_2_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.FACT_RELATIONSHIP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DOMAIN_CONCEPT_ID_2 = p.CONCEPT_ID
WHERE
  NOT c.DOMAIN_CONCEPT_ID_2 IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name fact_relationship_domain_concept_id_2_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.FACT_RELATIONSHIP
WHERE
  DOMAIN_CONCEPT_ID_2 = 0;

AUDIT (
  name fact_relationship_fact_id_1_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.FACT_RELATIONSHIP
WHERE
  FACT_ID_1 IS NULL;

AUDIT (
  name fact_relationship_fact_id_2_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.FACT_RELATIONSHIP
WHERE
  FACT_ID_2 IS NULL;

AUDIT (
  name fact_relationship_relationship_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.FACT_RELATIONSHIP
WHERE
  RELATIONSHIP_CONCEPT_ID IS NULL;

AUDIT (
  name fact_relationship_relationship_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.FACT_RELATIONSHIP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.RELATIONSHIP_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.RELATIONSHIP_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name fact_relationship_relationship_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.FACT_RELATIONSHIP
WHERE
  RELATIONSHIP_CONCEPT_ID = 0