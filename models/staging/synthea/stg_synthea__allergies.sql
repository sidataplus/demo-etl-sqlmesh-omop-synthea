MODEL (
  name stg.synthea__allergies,
  description "Synthea allergies table",
  kind VIEW,
  columns (
    allergy_start_date DATE,
    allergy_stop_date DATE,
    patient_id TEXT,
    encounter_id TEXT,
    allergy_code TEXT,
    allergy_code_system TEXT,
    allergy_description TEXT,
    allergy_type TEXT,
    allergy_category TEXT,
    reaction_1_code TEXT,
    reaction_1_description TEXT,
    reaction_1_severity TEXT,
    reaction_2_code TEXT,
    reaction_2_description TEXT,
    reaction_2_severity TEXT
  ),
  column_descriptions (
    allergy_start_date = 'The date the allergy was diagnosed.',
    allergy_stop_date = 'The date the allergy ended, if applicable.',
    patient_id = 'The patient ID.',
    encounter_id = 'The encounter ID.',
    allergy_code = 'The allergy code.',
    allergy_code_system = 'The allergy code system.',
    allergy_description = 'The allergy description.',
    allergy_type = 'Identify entry as an allergy or intolerance.',
    allergy_category = 'Identify the allergy category as drug, medication, food, or environment.',
    reaction_1_code = "Optional SNOMED code of the patient's reaction.",
    reaction_1_description = 'Optional description of the Reaction1 SNOMED code.',
    reaction_1_severity = 'Severity of the reaction: MILD, MODERATE, or SEVERE.',
    reaction_2_code = "Optional SNOMED code of the patient's second reaction.",
    reaction_2_description = 'Optional description of the Reaction2 SNOMED code.',
    reaction_2_severity = 'Severity of the second reaction: MILD, MODERATE, or SEVERE.'
  )
);

SELECT
  START AS allergy_start_date,
  STOP AS allergy_stop_date,
  PATIENT AS patient_id,
  ENCOUNTER AS encounter_id,
  CODE AS allergy_code,
  SYSTEM AS allergy_code_system,
  DESCRIPTION AS allergy_description,
  TYPE AS allergy_type,
  CATEGORY AS allergy_category,
  REACTION1 AS reaction_1_code,
  DESCRIPTION1 AS reaction_1_description,
  SEVERITY1 AS reaction_1_severity,
  REACTION2 AS reaction_2_code,
  DESCRIPTION2 AS reaction_2_description,
  SEVERITY2 AS reaction_2_severity
FROM synthea.allergies