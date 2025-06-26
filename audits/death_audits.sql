AUDIT (
  name person_completeness_death,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.DEATH AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name death_cause_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEATH AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.CAUSE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.CAUSE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name death_cause_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEATH AS t
LEFT JOIN omop.concept AS c
  ON t.CAUSE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.CAUSE_CONCEPT_ID IS NULL
  AND t.CAUSE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name death_cause_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEATH
WHERE
  CAUSE_CONCEPT_ID = 0;

AUDIT (
  name death_cause_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEATH AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.CAUSE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.CAUSE_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name death_death_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEATH
WHERE
  DEATH_DATE IS NULL;

AUDIT (
  name death_death_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEATH AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.DEATH_DATE < p.birth_datetime;

AUDIT (
  name death_death_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEATH AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.DEATH_DATETIME < p.birth_datetime;

AUDIT (
  name death_death_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEATH AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.DEATH_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.DEATH_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name death_death_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEATH AS t
JOIN omop.concept AS c
  ON t.DEATH_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name death_death_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.DEATH AS t
LEFT JOIN omop.concept AS c
  ON t.DEATH_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.DEATH_TYPE_CONCEPT_ID IS NULL
  AND t.DEATH_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name death_death_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEATH
WHERE
  DEATH_TYPE_CONCEPT_ID = 0;

AUDIT (
  name death_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.DEATH
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name death_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.DEATH AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL