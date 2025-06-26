AUDIT (
  name person_exists,
  dialect duckdb,
  blocking FALSE
);

SELECT
  1
FROM omop.PERSON
WHERE
  1 = 0;

AUDIT (
  name person_care_site_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PERSON AS c
LEFT JOIN omop.CARE_SITE AS p
  ON c.CARE_SITE_ID = p.CARE_SITE_ID
WHERE
  NOT c.CARE_SITE_ID IS NULL AND p.CARE_SITE_ID IS NULL;

AUDIT (
  name person_ethnicity_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PERSON
WHERE
  ETHNICITY_CONCEPT_ID IS NULL;

AUDIT (
  name person_ethnicity_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PERSON AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.ETHNICITY_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.ETHNICITY_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name person_ethnicity_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PERSON AS t
JOIN omop.concept AS c
  ON t.ETHNICITY_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Ethnicity';

AUDIT (
  name person_ethnicity_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PERSON AS t
LEFT JOIN omop.concept AS c
  ON t.ETHNICITY_CONCEPT_ID = c.concept_id
WHERE
  NOT t.ETHNICITY_CONCEPT_ID IS NULL
  AND t.ETHNICITY_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name person_ethnicity_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PERSON
WHERE
  ETHNICITY_CONCEPT_ID = 0;

AUDIT (
  name person_ethnicity_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PERSON AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.ETHNICITY_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.ETHNICITY_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name person_gender_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PERSON
WHERE
  GENDER_CONCEPT_ID IS NULL;

AUDIT (
  name person_gender_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PERSON AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.GENDER_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.GENDER_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name person_gender_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PERSON AS t
JOIN omop.concept AS c
  ON t.GENDER_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Gender';

AUDIT (
  name person_gender_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PERSON AS t
LEFT JOIN omop.concept AS c
  ON t.GENDER_CONCEPT_ID = c.concept_id
WHERE
  NOT t.GENDER_CONCEPT_ID IS NULL
  AND t.GENDER_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name person_gender_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PERSON
WHERE
  GENDER_CONCEPT_ID = 0;

AUDIT (
  name person_gender_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PERSON AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.GENDER_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.GENDER_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name person_location_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PERSON AS c
LEFT JOIN omop.LOCATION AS p
  ON c.LOCATION_ID = p.LOCATION_ID
WHERE
  NOT c.LOCATION_ID IS NULL AND p.LOCATION_ID IS NULL;

AUDIT (
  name person_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PERSON
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name person_person_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  PERSON_ID,
  COUNT(*)
FROM omop.PERSON
WHERE
  NOT PERSON_ID IS NULL
GROUP BY
  PERSON_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name person_provider_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PERSON AS c
LEFT JOIN omop.PROVIDER AS p
  ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE
  NOT c.PROVIDER_ID IS NULL AND p.PROVIDER_ID IS NULL;

AUDIT (
  name person_race_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PERSON
WHERE
  RACE_CONCEPT_ID IS NULL;

AUDIT (
  name person_race_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PERSON AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.RACE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.RACE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name person_race_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PERSON AS t
JOIN omop.concept AS c
  ON t.RACE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Race';

AUDIT (
  name person_race_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PERSON AS t
LEFT JOIN omop.concept AS c
  ON t.RACE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.RACE_CONCEPT_ID IS NULL
  AND t.RACE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name person_race_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PERSON
WHERE
  RACE_CONCEPT_ID = 0;

AUDIT (
  name person_race_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PERSON AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.RACE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.RACE_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name person_year_of_birth_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PERSON
WHERE
  YEAR_OF_BIRTH IS NULL