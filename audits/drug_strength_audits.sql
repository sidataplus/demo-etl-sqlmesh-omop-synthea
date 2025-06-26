AUDIT (
  name drug_strength_amount_unit_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DRUG_STRENGTH AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.AMOUNT_UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.AMOUNT_UNIT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name drug_strength_denominator_unit_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DRUG_STRENGTH AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DENOMINATOR_UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DENOMINATOR_UNIT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name drug_strength_drug_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DRUG_STRENGTH
WHERE
  DRUG_CONCEPT_ID IS NULL;

AUDIT (
  name drug_strength_drug_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DRUG_STRENGTH AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DRUG_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DRUG_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name drug_strength_drug_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DRUG_STRENGTH AS t
JOIN omop.concept AS c
  ON t.DRUG_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Drug';

AUDIT (
  name drug_strength_ingredient_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DRUG_STRENGTH
WHERE
  INGREDIENT_CONCEPT_ID IS NULL;

AUDIT (
  name drug_strength_ingredient_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DRUG_STRENGTH AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.INGREDIENT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.INGREDIENT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name drug_strength_numerator_unit_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DRUG_STRENGTH AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.NUMERATOR_UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.NUMERATOR_UNIT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name drug_strength_valid_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DRUG_STRENGTH
WHERE
  VALID_END_DATE IS NULL;

AUDIT (
  name drug_strength_valid_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DRUG_STRENGTH
WHERE
  VALID_START_DATE IS NULL;

AUDIT (
  name drug_strength_valid_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DRUG_STRENGTH
WHERE
  VALID_START_DATE > VALID_END_DATE