AUDIT (
  name person_completeness_specimen,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.SPECIMEN AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name specimen_anatomic_site_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.SPECIMEN AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.ANATOMIC_SITE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.ANATOMIC_SITE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name specimen_anatomic_site_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.SPECIMEN AS t
LEFT JOIN omop.concept AS c
  ON t.ANATOMIC_SITE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.ANATOMIC_SITE_CONCEPT_ID IS NULL
  AND t.ANATOMIC_SITE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name specimen_disease_status_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.SPECIMEN AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DISEASE_STATUS_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DISEASE_STATUS_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name specimen_disease_status_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.SPECIMEN AS t
LEFT JOIN omop.concept AS c
  ON t.DISEASE_STATUS_CONCEPT_ID = c.concept_id
WHERE
  NOT t.DISEASE_STATUS_CONCEPT_ID IS NULL
  AND t.DISEASE_STATUS_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name specimen_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SPECIMEN
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name specimen_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.SPECIMEN AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name specimen_specimen_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SPECIMEN
WHERE
  SPECIMEN_CONCEPT_ID IS NULL;

AUDIT (
  name specimen_specimen_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.SPECIMEN AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.SPECIMEN_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.SPECIMEN_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name specimen_specimen_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.SPECIMEN AS t
LEFT JOIN omop.concept AS c
  ON t.SPECIMEN_CONCEPT_ID = c.concept_id
WHERE
  NOT t.SPECIMEN_CONCEPT_ID IS NULL
  AND t.SPECIMEN_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name specimen_specimen_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SPECIMEN
WHERE
  SPECIMEN_CONCEPT_ID = 0;

AUDIT (
  name specimen_specimen_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SPECIMEN
WHERE
  SPECIMEN_DATE IS NULL;

AUDIT (
  name specimen_specimen_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.SPECIMEN AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.SPECIMEN_DATE < p.birth_datetime;

AUDIT (
  name specimen_specimen_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.SPECIMEN AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.SPECIMEN_DATETIME < p.birth_datetime;

AUDIT (
  name specimen_specimen_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SPECIMEN
WHERE
  SPECIMEN_ID IS NULL;

AUDIT (
  name specimen_specimen_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  SPECIMEN_ID,
  COUNT(*)
FROM omop.SPECIMEN
WHERE
  NOT SPECIMEN_ID IS NULL
GROUP BY
  SPECIMEN_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name specimen_specimen_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SPECIMEN
WHERE
  SPECIMEN_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name specimen_specimen_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.SPECIMEN AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.SPECIMEN_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.SPECIMEN_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name specimen_specimen_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.SPECIMEN AS t
JOIN omop.concept AS c
  ON t.SPECIMEN_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name specimen_specimen_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.SPECIMEN AS t
LEFT JOIN omop.concept AS c
  ON t.SPECIMEN_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.SPECIMEN_TYPE_CONCEPT_ID IS NULL
  AND t.SPECIMEN_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name specimen_specimen_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SPECIMEN
WHERE
  SPECIMEN_TYPE_CONCEPT_ID = 0;

AUDIT (
  name specimen_unit_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.SPECIMEN AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.UNIT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name specimen_unit_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.SPECIMEN AS t
LEFT JOIN omop.concept AS c
  ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE
  NOT t.UNIT_CONCEPT_ID IS NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name specimen_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.SPECIMEN
WHERE
  UNIT_CONCEPT_ID = 0