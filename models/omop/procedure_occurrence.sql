MODEL (
  name omop.procedure_occurrence,
  kind FULL,
  description "Contains records of activities or processes ordered by, or carried out by, a healthcare provider on the patient with a diagnostic or therapeutic purpose.",
  column_descriptions (
    procedure_occurrence_id = "A unique identifier for each procedure occurrence.",
    person_id = "A foreign key identifier to the Person on whom the procedure was performed.",
    procedure_concept_id = "A foreign key identifier to the Standard Concept for the procedure.",
    procedure_date = "The date when the procedure occurred.",
    procedure_datetime = "The date and time when the procedure occurred.",
    procedure_end_date = "The date when the procedure ended.",
    procedure_end_datetime = "The date and time when the procedure ended.",
    procedure_type_concept_id = "A foreign key identifier to the Concept defining the type of procedure occurrence.",
    modifier_concept_id = "A foreign key identifier to the Concept providing additional information about the procedure.",
    quantity = "The number of procedures performed.",
    provider_id = "A foreign key identifier to the Provider who performed the procedure.",
    visit_occurrence_id = "A foreign key identifier to the Visit Occurrence during which the procedure occurred.",
    visit_detail_id = "A foreign key identifier to the Visit Detail during which the procedure occurred.",
    procedure_source_value = "The source code for the procedure as it appears in the source data.",
    procedure_source_concept_id = "A foreign key identifier to a Procedure Concept that refers to the code used in the source.",
    modifier_source_value = "The source value for the procedure modifier."
  )
);

SELECT
    po.procedure_occurrence_id
    , po.person_id
    , po.procedure_concept_id
    , po.procedure_date
    , po.procedure_datetime
    , po.procedure_end_date
    , po.procedure_end_datetime
    , po.procedure_type_concept_id
    , po.modifier_concept_id
    , po.quantity
    , vd.provider_id
    , vd.visit_occurrence_id
    , vd.visit_detail_id
    , po.procedure_source_value
    , po.procedure_source_concept_id
    , po.modifier_source_value
FROM int.procedure_occurrence AS po
LEFT JOIN int.visit_detail AS vd
    ON po.encounter_id = vd.encounter_id
