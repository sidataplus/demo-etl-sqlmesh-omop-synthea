MODEL (
  name omop.note_nlp,
  kind FULL,
  description "The NOTE_NLP table encodes all output of NLP on clinical notes. Each row represents a single extracted term.",
  columns (
    note_nlp_id BIGINT,
    note_id BIGINT,
    section_concept_id INT,
    snippet TEXT,
    "offset" TEXT,
    lexical_variant TEXT,
    note_nlp_concept_id INT,
    note_nlp_source_concept_id INT,
    nlp_system TEXT,
    nlp_date DATE,
    nlp_datetime TIMESTAMP,
    term_exists TEXT,
    term_temporal TEXT,
    term_modifiers TEXT
  ),
  column_descriptions (
    note_nlp_id = 'A unique identifier for the NLP record.',
    note_id = 'A foreign key identifier to the NOTE record.',
    section_concept_id = 'A foreign key identifier to the Concept representing the section of the note.',
    snippet = 'A small window of text surrounding the term.',
    "offset" = 'Character offset of the extracted term in the input note.',
    lexical_variant = 'Raw text extracted from the NLP tool.',
    note_nlp_concept_id = 'A foreign key identifier to the Concept representing the extracted term.',
    note_nlp_source_concept_id = 'A foreign key identifier to the Concept representing the source term.',
    nlp_system = 'Identifier for the NLP system used.',
    nlp_date = 'The date of the note processing.',
    nlp_datetime = 'The date and time of the note processing.',
    term_exists = 'Flag indicating if the term exists.',
    term_temporal = 'Temporal context of the term.',
    term_modifiers = 'Modifiers associated with the term.'
  ),
  audits (
    note_nlp_lexical_variant_is_required,
    note_nlp_nlp_date_is_required,
    note_nlp_note_id_is_required,
    note_nlp_note_nlp_concept_id_is_foreign_key,
    note_nlp_note_nlp_concept_id_is_standard_valid_concept,
    note_nlp_note_nlp_id_is_required,
    note_nlp_note_nlp_id_is_primary_key,
    note_nlp_note_nlp_source_concept_id_is_foreign_key,
    note_nlp_section_concept_id_is_foreign_key,
    note_nlp_section_concept_id_is_standard_valid_concept
  )
);

/* Note: Requires NLP processing on the NOTE table, which is empty in this ETL. */ /* Creating an empty table structure for compatibility. */
SELECT
  NULL::BIGINT AS note_nlp_id,
  NULL::BIGINT AS note_id,
  NULL::INT AS section_concept_id,
  NULL::TEXT AS snippet,
  NULL::TEXT AS "offset",
  NULL::TEXT AS lexical_variant,
  NULL::INT AS note_nlp_concept_id,
  NULL::INT AS note_nlp_source_concept_id,
  NULL::TEXT AS nlp_system,
  NULL::DATE AS nlp_date,
  NULL::TIMESTAMP AS nlp_datetime,
  NULL::TEXT AS term_exists,
  NULL::TEXT AS term_temporal,
  NULL::TEXT AS term_modifiers
WHERE
  1 = 0