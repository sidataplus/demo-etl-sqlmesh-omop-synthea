AUDIT (
  name provider_care_site_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROVIDER AS c
LEFT JOIN omop.CARE_SITE AS p
  ON c.CARE_SITE_ID = p.CARE_SITE_ID
WHERE
  NOT c.CARE_SITE_ID IS NULL AND p.CARE_SITE_ID IS NULL;

AUDIT (
  name provider_gender_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROVIDER AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.GENDER_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.GENDER_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name provider_gender_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROVIDER AS t
JOIN omop.concept AS c
  ON t.GENDER_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Gender';

AUDIT (
  name provider_gender_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROVIDER AS t
LEFT JOIN omop.concept AS c
  ON t.GENDER_CONCEPT_ID = c.concept_id
WHERE
  NOT t.GENDER_CONCEPT_ID IS NULL
  AND t.GENDER_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name provider_gender_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROVIDER
WHERE
  GENDER_CONCEPT_ID = 0;

AUDIT (
  name provider_gender_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROVIDER AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.GENDER_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.GENDER_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name provider_provider_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROVIDER
WHERE
  PROVIDER_ID IS NULL;

AUDIT (
  name provider_provider_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  PROVIDER_ID,
  COUNT(*)
FROM omop.PROVIDER
WHERE
  NOT PROVIDER_ID IS NULL
GROUP BY
  PROVIDER_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name provider_specialty_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROVIDER AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.SPECIALTY_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.SPECIALTY_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name provider_specialty_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROVIDER AS t
LEFT JOIN omop.concept AS c
  ON t.SPECIALTY_CONCEPT_ID = c.concept_id
WHERE
  NOT t.SPECIALTY_CONCEPT_ID IS NULL
  AND t.SPECIALTY_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name provider_specialty_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROVIDER
WHERE
  SPECIALTY_CONCEPT_ID = 0;

AUDIT (
  name provider_specialty_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROVIDER AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.SPECIALTY_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.SPECIALTY_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL