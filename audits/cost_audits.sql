AUDIT (
  name cost_cost_domain_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COST
WHERE
  COST_DOMAIN_ID IS NULL;

AUDIT (
  name cost_cost_domain_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.COST AS c
LEFT JOIN omop.DOMAIN AS p
  ON c.COST_DOMAIN_ID = p.DOMAIN_ID
WHERE
  NOT c.COST_DOMAIN_ID IS NULL AND p.DOMAIN_ID IS NULL;

AUDIT (
  name cost_cost_event_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COST
WHERE
  COST_EVENT_ID IS NULL;

AUDIT (
  name cost_cost_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COST
WHERE
  COST_ID IS NULL;

AUDIT (
  name cost_cost_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  COST_ID,
  COUNT(*)
FROM omop.COST
WHERE
  NOT COST_ID IS NULL
GROUP BY
  COST_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name cost_cost_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COST
WHERE
  COST_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name cost_cost_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.COST AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.COST_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.COST_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name cost_cost_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.COST AS t
LEFT JOIN omop.concept AS c
  ON t.COST_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.COST_TYPE_CONCEPT_ID IS NULL
  AND t.COST_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name cost_cost_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.COST
WHERE
  COST_TYPE_CONCEPT_ID = 0;

AUDIT (
  name cost_currency_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.COST AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.CURRENCY_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.CURRENCY_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name cost_drg_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.COST AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DRG_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DRG_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name cost_revenue_code_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.COST AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.REVENUE_CODE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.REVENUE_CODE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL