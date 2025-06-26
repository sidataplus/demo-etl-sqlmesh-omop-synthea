AUDIT (
  name note_nlp_lexical_variant_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE_NLP
WHERE
  LEXICAL_VARIANT IS NULL;

AUDIT (
  name note_nlp_nlp_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE_NLP
WHERE
  NLP_DATE IS NULL;

AUDIT (
  name note_nlp_note_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE_NLP
WHERE
  NOTE_ID IS NULL;

AUDIT (
  name note_nlp_note_nlp_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE_NLP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.NOTE_NLP_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.NOTE_NLP_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name note_nlp_note_nlp_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE_NLP AS t
LEFT JOIN omop.concept AS c
  ON t.NOTE_NLP_CONCEPT_ID = c.concept_id
WHERE
  NOT t.NOTE_NLP_CONCEPT_ID IS NULL
  AND t.NOTE_NLP_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name note_nlp_note_nlp_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.NOTE_NLP
WHERE
  NOTE_NLP_ID IS NULL;

AUDIT (
  name note_nlp_note_nlp_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  NOTE_NLP_ID,
  COUNT(*)
FROM omop.NOTE_NLP
WHERE
  NOT NOTE_NLP_ID IS NULL
GROUP BY
  NOTE_NLP_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name note_nlp_note_nlp_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE_NLP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.NOTE_NLP_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.NOTE_NLP_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name note_nlp_section_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.NOTE_NLP AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.SECTION_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.SECTION_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name note_nlp_section_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.NOTE_NLP AS t
LEFT JOIN omop.concept AS c
  ON t.SECTION_CONCEPT_ID = c.concept_id
WHERE
  NOT t.SECTION_CONCEPT_ID IS NULL
  AND t.SECTION_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  )