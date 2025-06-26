AUDIT (
  name cdm_source_cdm_holder_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CDM_SOURCE
WHERE
  CDM_HOLDER IS NULL;

AUDIT (
  name cdm_source_cdm_release_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CDM_SOURCE
WHERE
  CDM_RELEASE_DATE IS NULL;

AUDIT (
  name cdm_source_cdm_source_abbreviation_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CDM_SOURCE
WHERE
  CDM_SOURCE_ABBREVIATION IS NULL;

AUDIT (
  name cdm_source_cdm_source_name_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CDM_SOURCE
WHERE
  CDM_SOURCE_NAME IS NULL;

AUDIT (
  name cdm_source_cdm_version_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CDM_SOURCE
WHERE
  CDM_VERSION_CONCEPT_ID IS NULL;

AUDIT (
  name cdm_source_cdm_version_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.CDM_SOURCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.CDM_VERSION_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.CDM_VERSION_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name cdm_source_cdm_version_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.CDM_SOURCE AS t
JOIN omop.concept AS c
  ON t.CDM_VERSION_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Metadata';

AUDIT (
  name cdm_source_cdm_version_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.CDM_SOURCE AS t
LEFT JOIN omop.concept AS c
  ON t.CDM_VERSION_CONCEPT_ID = c.concept_id
WHERE
  NOT t.CDM_VERSION_CONCEPT_ID IS NULL
  AND t.CDM_VERSION_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name cdm_source_source_release_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CDM_SOURCE
WHERE
  SOURCE_RELEASE_DATE IS NULL;

AUDIT (
  name cdm_source_source_release_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CDM_SOURCE
WHERE
  SOURCE_RELEASE_DATE > SOURCE_RELEASE_DATE;

AUDIT (
  name cdm_source_vocabulary_version_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.CDM_SOURCE
WHERE
  VOCABULARY_VERSION IS NULL