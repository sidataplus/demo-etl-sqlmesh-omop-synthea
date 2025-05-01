MODEL (
  name omop.note_nlp,
  kind FULL,
  description "The NOTE_NLP table encodes all output of NLP on clinical notes. Each row represents a single extracted term.",
  columns (
    note_nlp_id BIGINT,
    note_id BIGINT,
    section_concept_id INT,
    snippet VARCHAR(250),
    "offset" VARCHAR(50),
    lexical_variant VARCHAR(250),
    note_nlp_concept_id INT,
    note_nlp_source_concept_id INT,
    nlp_system VARCHAR(250),
    nlp_date DATE,
    nlp_datetime TIMESTAMP,
    term_exists VARCHAR(1),
    term_temporal VARCHAR(50),
    term_modifiers VARCHAR(2000)
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
  )
);

-- Note: Requires NLP processing on the NOTE table, which is empty in this ETL.
-- Creating an empty table structure for compatibility.
SELECT
    CAST(NULL AS BIGINT) AS note_nlp_id,
    CAST(NULL AS BIGINT) AS note_id,
    CAST(NULL AS INT) AS section_concept_id,
    CAST(NULL AS VARCHAR(250)) AS snippet,
    CAST(NULL AS VARCHAR(50)) AS "offset",
    CAST(NULL AS VARCHAR(250)) AS lexical_variant,
    CAST(NULL AS INT) AS note_nlp_concept_id,
    CAST(NULL AS INT) AS note_nlp_source_concept_id,
    CAST(NULL AS VARCHAR(250)) AS nlp_system,
    CAST(NULL AS DATE) AS nlp_date,
    CAST(NULL AS TIMESTAMP) AS nlp_datetime,
    CAST(NULL AS VARCHAR(1)) AS term_exists,
    CAST(NULL AS VARCHAR(50)) AS term_temporal,
    CAST(NULL AS VARCHAR(2000)) AS term_modifiers
WHERE 1 = 0