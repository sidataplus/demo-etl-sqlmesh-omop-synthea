AUDIT (
  name person_completeness_visit_occurrence,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.VISIT_OCCURRENCE AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name visit_occurrence_admitted_from_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_OCCURRENCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.ADMITTED_FROM_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.ADMITTED_FROM_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_occurrence_admitted_from_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
JOIN omop.concept AS c
  ON t.ADMITTED_FROM_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Visit';

AUDIT (
  name visit_occurrence_admitted_from_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
LEFT JOIN omop.concept AS c
  ON t.ADMITTED_FROM_CONCEPT_ID = c.concept_id
WHERE
  NOT t.ADMITTED_FROM_CONCEPT_ID IS NULL
  AND t.ADMITTED_FROM_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name visit_occurrence_admitted_from_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  ADMITTED_FROM_CONCEPT_ID = 0;

AUDIT (
  name visit_occurrence_care_site_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_OCCURRENCE AS c
LEFT JOIN omop.CARE_SITE AS p
  ON c.CARE_SITE_ID = p.CARE_SITE_ID
WHERE
  NOT c.CARE_SITE_ID IS NULL AND p.CARE_SITE_ID IS NULL;

AUDIT (
  name visit_occurrence_discharged_to_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_OCCURRENCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DISCHARGED_TO_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DISCHARGED_TO_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_occurrence_discharged_to_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
JOIN omop.concept AS c
  ON t.DISCHARGED_TO_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Visit';

AUDIT (
  name visit_occurrence_discharged_to_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
LEFT JOIN omop.concept AS c
  ON t.DISCHARGED_TO_CONCEPT_ID = c.concept_id
WHERE
  NOT t.DISCHARGED_TO_CONCEPT_ID IS NULL
  AND t.DISCHARGED_TO_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name visit_occurrence_discharged_to_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  DISCHARGED_TO_CONCEPT_ID = 0;

AUDIT (
  name visit_occurrence_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name visit_occurrence_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_OCCURRENCE AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name visit_occurrence_preceding_visit_occurrence_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_OCCURRENCE AS c
LEFT JOIN omop.VISIT_OCCURRENCE AS p
  ON c.PRECEDING_VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE
  NOT c.PRECEDING_VISIT_OCCURRENCE_ID IS NULL AND p.VISIT_OCCURRENCE_ID IS NULL;

AUDIT (
  name visit_occurrence_provider_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_OCCURRENCE AS c
LEFT JOIN omop.PROVIDER AS p
  ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE
  NOT c.PROVIDER_ID IS NULL AND p.PROVIDER_ID IS NULL;

AUDIT (
  name visit_occurrence_visit_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_CONCEPT_ID IS NULL;

AUDIT (
  name visit_occurrence_visit_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_OCCURRENCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VISIT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VISIT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_occurrence_visit_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
JOIN omop.concept AS c
  ON t.VISIT_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Visit';

AUDIT (
  name visit_occurrence_visit_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
LEFT JOIN omop.concept AS c
  ON t.VISIT_CONCEPT_ID = c.concept_id
WHERE
  NOT t.VISIT_CONCEPT_ID IS NULL
  AND t.VISIT_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name visit_occurrence_visit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_CONCEPT_ID = 0;

AUDIT (
  name visit_occurrence_visit_end_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_END_DATE IS NULL;

AUDIT (
  name visit_occurrence_visit_end_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.VISIT_END_DATE < p.birth_datetime;

AUDIT (
  name visit_occurrence_visit_end_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.VISIT_END_DATETIME < p.birth_datetime;

AUDIT (
  name visit_occurrence_visit_occurrence_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_OCCURRENCE_ID IS NULL;

AUDIT (
  name visit_occurrence_visit_occurrence_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  VISIT_OCCURRENCE_ID,
  COUNT(*)
FROM omop.VISIT_OCCURRENCE
WHERE
  NOT VISIT_OCCURRENCE_ID IS NULL
GROUP BY
  VISIT_OCCURRENCE_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name visit_occurrence_visit_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_OCCURRENCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VISIT_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VISIT_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_occurrence_visit_start_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_START_DATE IS NULL;

AUDIT (
  name visit_occurrence_visit_start_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_START_DATE > VISIT_END_DATE;

AUDIT (
  name visit_occurrence_visit_start_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.VISIT_START_DATE < p.birth_datetime;

AUDIT (
  name visit_occurrence_visit_start_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_START_DATETIME > VISIT_END_DATETIME;

AUDIT (
  name visit_occurrence_visit_start_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.VISIT_START_DATETIME < p.birth_datetime;

AUDIT (
  name visit_occurrence_visit_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name visit_occurrence_visit_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.VISIT_OCCURRENCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VISIT_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VISIT_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name visit_occurrence_visit_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
JOIN omop.concept AS c
  ON t.VISIT_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name visit_occurrence_visit_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.VISIT_OCCURRENCE AS t
LEFT JOIN omop.concept AS c
  ON t.VISIT_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.VISIT_TYPE_CONCEPT_ID IS NULL
  AND t.VISIT_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name visit_occurrence_visit_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_TYPE_CONCEPT_ID = 0;

AUDIT (
  name visit_occurrence_9201_temp,
  dialect duckdb,
  blocking FALSE
);

SELECT
  person_id,
  COUNT(*) AS num_records
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_CONCEPT_ID = 9201
GROUP BY
  person_id
HAVING
  COUNT(*) > 1;

AUDIT (
  name visit_occurrence_9202_temp,
  dialect duckdb,
  blocking FALSE
);

SELECT
  person_id,
  COUNT(*) AS num_records
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_CONCEPT_ID = 9202
GROUP BY
  person_id
HAVING
  COUNT(*) > 1;

AUDIT (
  name visit_occurrence_9203_temp,
  dialect duckdb,
  blocking FALSE
);

SELECT
  person_id,
  COUNT(*) AS num_records
FROM omop.VISIT_OCCURRENCE
WHERE
  VISIT_CONCEPT_ID = 9203
GROUP BY
  person_id
HAVING
  COUNT(*) > 1