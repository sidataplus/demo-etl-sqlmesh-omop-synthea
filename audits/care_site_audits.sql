AUDIT (
  name care_site_care_site_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CARE_SITE
WHERE
  CARE_SITE_ID IS NULL;

AUDIT (
  name care_site_care_site_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  CARE_SITE_ID,
  COUNT(*)
FROM omop.CARE_SITE
WHERE
  NOT CARE_SITE_ID IS NULL
GROUP BY
  CARE_SITE_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name care_site_location_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CARE_SITE AS c
LEFT JOIN omop.LOCATION AS p
  ON c.LOCATION_ID = p.LOCATION_ID
WHERE
  NOT c.LOCATION_ID IS NULL AND p.LOCATION_ID IS NULL;

AUDIT (
  name care_site_place_of_service_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CARE_SITE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.PLACE_OF_SERVICE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.PLACE_OF_SERVICE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name care_site_place_of_service_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.CARE_SITE AS t
LEFT JOIN omop.concept AS c
  ON t.PLACE_OF_SERVICE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.PLACE_OF_SERVICE_CONCEPT_ID IS NULL
  AND t.PLACE_OF_SERVICE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name care_site_place_of_service_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CARE_SITE
WHERE
  PLACE_OF_SERVICE_CONCEPT_ID = 0