AUDIT (
  name person_completeness_visit_detail,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.VISIT_DETAIL AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name visit_detail_admitted_from_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.ADMITTED_FROM_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.ADMITTED_FROM_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_detail_admitted_from_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
JOIN omop.concept AS c
  ON t.ADMITTED_FROM_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Visit';

AUDIT (
  name visit_detail_admitted_from_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
LEFT JOIN omop.concept AS c
  ON t.ADMITTED_FROM_CONCEPT_ID = c.concept_id
WHERE
  NOT t.ADMITTED_FROM_CONCEPT_ID IS NULL
  AND t.ADMITTED_FROM_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name visit_detail_admitted_from_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  ADMITTED_FROM_CONCEPT_ID = 0;

AUDIT (
  name visit_detail_care_site_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.CARE_SITE AS p
  ON c.CARE_SITE_ID = p.CARE_SITE_ID
WHERE
  NOT c.CARE_SITE_ID IS NULL AND p.CARE_SITE_ID IS NULL;

AUDIT (
  name visit_detail_discharged_to_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DISCHARGED_TO_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DISCHARGED_TO_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_detail_discharged_to_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
JOIN omop.concept AS c
  ON t.DISCHARGED_TO_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Visit';

AUDIT (
  name visit_detail_discharged_to_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
LEFT JOIN omop.concept AS c
  ON t.DISCHARGED_TO_CONCEPT_ID = c.concept_id
WHERE
  NOT t.DISCHARGED_TO_CONCEPT_ID IS NULL
  AND t.DISCHARGED_TO_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name visit_detail_discharged_to_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  DISCHARGED_TO_CONCEPT_ID = 0;

AUDIT (
  name visit_detail_parent_visit_detail_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.VISIT_DETAIL AS p
  ON c.PARENT_VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE
  NOT c.PARENT_VISIT_DETAIL_ID IS NULL AND p.VISIT_DETAIL_ID IS NULL;

AUDIT (
  name visit_detail_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name visit_detail_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name visit_detail_preceding_visit_detail_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.VISIT_DETAIL AS p
  ON c.PRECEDING_VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE
  NOT c.PRECEDING_VISIT_DETAIL_ID IS NULL AND p.VISIT_DETAIL_ID IS NULL;

AUDIT (
  name visit_detail_provider_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.PROVIDER AS p
  ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE
  NOT c.PROVIDER_ID IS NULL AND p.PROVIDER_ID IS NULL;

AUDIT (
  name visit_detail_visit_detail_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_DETAIL_CONCEPT_ID IS NULL;

AUDIT (
  name visit_detail_visit_detail_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VISIT_DETAIL_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VISIT_DETAIL_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_detail_visit_detail_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
JOIN omop.concept AS c
  ON t.VISIT_DETAIL_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Visit';

AUDIT (
  name visit_detail_visit_detail_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
LEFT JOIN omop.concept AS c
  ON t.VISIT_DETAIL_CONCEPT_ID = c.concept_id
WHERE
  NOT t.VISIT_DETAIL_CONCEPT_ID IS NULL
  AND t.VISIT_DETAIL_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name visit_detail_visit_detail_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_DETAIL_CONCEPT_ID = 0;

AUDIT (
  name visit_detail_visit_detail_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_DETAIL_END_DATE IS NULL;

AUDIT (
  name visit_detail_visit_detail_end_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.VISIT_DETAIL_END_DATE < p.birth_datetime;

AUDIT (
  name visit_detail_visit_detail_end_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.VISIT_DETAIL_END_DATETIME < p.birth_datetime;

AUDIT (
  name visit_detail_visit_detail_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_DETAIL_ID IS NULL;

AUDIT (
  name visit_detail_visit_detail_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  VISIT_DETAIL_ID,
  COUNT(*)
FROM omop.VISIT_DETAIL
WHERE
  NOT VISIT_DETAIL_ID IS NULL
GROUP BY
  VISIT_DETAIL_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name visit_detail_visit_detail_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VISIT_DETAIL_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VISIT_DETAIL_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_detail_visit_detail_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_DETAIL_START_DATE IS NULL;

AUDIT (
  name visit_detail_visit_detail_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_DETAIL_START_DATE > VISIT_DETAIL_END_DATE;

AUDIT (
  name visit_detail_visit_detail_start_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.VISIT_DETAIL_START_DATE < p.birth_datetime;

AUDIT (
  name visit_detail_visit_detail_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_DETAIL_START_DATETIME > VISIT_DETAIL_END_DATETIME;

AUDIT (
  name visit_detail_visit_detail_start_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.VISIT_DETAIL_START_DATETIME < p.birth_datetime;

AUDIT (
  name visit_detail_visit_detail_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_DETAIL_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name visit_detail_visit_detail_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VISIT_DETAIL_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VISIT_DETAIL_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_detail_visit_detail_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
JOIN omop.concept AS c
  ON t.VISIT_DETAIL_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name visit_detail_visit_detail_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_DETAIL AS t
LEFT JOIN omop.concept AS c
  ON t.VISIT_DETAIL_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.VISIT_DETAIL_TYPE_CONCEPT_ID IS NULL
  AND t.VISIT_DETAIL_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name visit_detail_visit_detail_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_DETAIL_TYPE_CONCEPT_ID = 0;

AUDIT (
  name visit_detail_visit_occurrence_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_DETAIL
WHERE
  VISIT_OCCURRENCE_ID IS NULL;

AUDIT (
  name visit_detail_visit_occurrence_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_DETAIL AS c
LEFT JOIN omop.VISIT_OCCURRENCE AS p
  ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE
  NOT c.VISIT_OCCURRENCE_ID IS NULL AND p.VISIT_OCCURRENCE_ID IS NULL