AUDIT (
  name location_country_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.LOCATION AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.COUNTRY_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.COUNTRY_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name location_country_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.LOCATION AS t
JOIN omop.concept AS c
  ON t.COUNTRY_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Geography';

AUDIT (
  name location_country_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.LOCATION AS t
LEFT JOIN omop.concept AS c
  ON t.COUNTRY_CONCEPT_ID = c.concept_id
WHERE
  NOT t.COUNTRY_CONCEPT_ID IS NULL
  AND t.COUNTRY_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name location_country_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.LOCATION
WHERE
  COUNTRY_CONCEPT_ID = 0;

AUDIT (
  name location_location_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.LOCATION
WHERE
  LOCATION_ID IS NULL;

AUDIT (
  name location_location_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  LOCATION_ID,
  COUNT(*)
FROM omop.LOCATION
WHERE
  NOT LOCATION_ID IS NULL
GROUP BY
  LOCATION_ID
HAVING
  COUNT(*) > 1