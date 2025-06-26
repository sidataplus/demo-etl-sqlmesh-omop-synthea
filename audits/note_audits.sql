AUDIT (
  name person_completeness_note,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.NOTE AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name note_encoding_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE
WHERE
  ENCODING_CONCEPT_ID IS NULL;

AUDIT (
  name note_encoding_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.ENCODING_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.ENCODING_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name note_encoding_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE AS t
LEFT JOIN omop.concept AS c
  ON t.ENCODING_CONCEPT_ID = c.concept_id
WHERE
  NOT t.ENCODING_CONCEPT_ID IS NULL
  AND t.ENCODING_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name note_language_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE
WHERE
  LANGUAGE_CONCEPT_ID IS NULL;

AUDIT (
  name note_language_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.LANGUAGE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.LANGUAGE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name note_language_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE AS t
LEFT JOIN omop.concept AS c
  ON t.LANGUAGE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.LANGUAGE_CONCEPT_ID IS NULL
  AND t.LANGUAGE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name note_note_class_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE
WHERE
  NOTE_CLASS_CONCEPT_ID IS NULL;

AUDIT (
  name note_note_class_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.NOTE_CLASS_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.NOTE_CLASS_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name note_note_class_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE AS t
LEFT JOIN omop.concept AS c
  ON t.NOTE_CLASS_CONCEPT_ID = c.concept_id
WHERE
  NOT t.NOTE_CLASS_CONCEPT_ID IS NULL
  AND t.NOTE_CLASS_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name note_note_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE
WHERE
  NOTE_DATE IS NULL;

AUDIT (
  name note_note_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.NOTE_DATE < p.birth_datetime;

AUDIT (
  name note_note_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.NOTE_DATETIME < p.birth_datetime;

AUDIT (
  name note_note_event_field_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.NOTE_EVENT_FIELD_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.NOTE_EVENT_FIELD_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name note_note_event_field_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE AS t
LEFT JOIN omop.concept AS c
  ON t.NOTE_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE
  NOT t.NOTE_EVENT_FIELD_CONCEPT_ID IS NULL
  AND t.NOTE_EVENT_FIELD_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name note_note_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE
WHERE
  NOTE_ID IS NULL;

AUDIT (
  name note_note_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  NOTE_ID,
  COUNT(*)
FROM omop.NOTE
WHERE
  NOT NOTE_ID IS NULL
GROUP BY
  NOTE_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name note_note_text_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE
WHERE
  NOTE_TEXT IS NULL;

AUDIT (
  name note_note_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE
WHERE
  NOTE_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name note_note_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.NOTE_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.NOTE_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name note_note_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE AS t
JOIN omop.concept AS c
  ON t.NOTE_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name note_note_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE AS t
LEFT JOIN omop.concept AS c
  ON t.NOTE_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.NOTE_TYPE_CONCEPT_ID IS NULL
  AND t.NOTE_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name note_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name note_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name note_provider_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE AS c
LEFT JOIN omop.PROVIDER AS p
  ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE
  NOT c.PROVIDER_ID IS NULL AND p.PROVIDER_ID IS NULL;

AUDIT (
  name note_visit_detail_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE AS c
LEFT JOIN omop.VISIT_DETAIL AS p
  ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE
  NOT c.VISIT_DETAIL_ID IS NULL AND p.VISIT_DETAIL_ID IS NULL;

AUDIT (
  name note_visit_occurrence_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE AS c
LEFT JOIN omop.VISIT_OCCURRENCE AS p
  ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE
  NOT c.VISIT_OCCURRENCE_ID IS NULL AND p.VISIT_OCCURRENCE_ID IS NULL