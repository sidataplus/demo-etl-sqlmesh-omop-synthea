MODEL (
  name omop.visit_detail,
  kind FULL,
  description "Represents sub-visits or encounters within a larger Visit Occurrence, such as an ICU stay during a hospitalization.",
  column_descriptions (
    visit_detail_id = "A unique identifier for each visit detail.",
    person_id = "A foreign key identifier to the Person associated with the visit detail.",
    visit_detail_concept_id = "A foreign key identifier to the Standard Concept for the visit detail type.",
    visit_detail_start_date = "The start date of the visit detail.",
    visit_detail_start_datetime = "The start date and time of the visit detail.",
    visit_detail_end_date = "The end date of the visit detail.",
    visit_detail_end_datetime = "The end date and time of the visit detail.",
    visit_detail_type_concept_id = "A foreign key identifier to the Concept defining the type of visit detail record.",
    provider_id = "A foreign key identifier to the Provider associated with the visit detail.",
    care_site_id = "A foreign key identifier to the Care Site where the visit detail occurred.",
    visit_detail_source_value = "The source value for the visit detail type.",
    visit_detail_source_concept_id = "A foreign key identifier to a Concept that refers to the visit detail source value.",
    admitted_from_concept_id = "A foreign key identifier to the Concept indicating where the patient was admitted from.",
    admitted_from_source_value = "The source value indicating where the patient was admitted from.",
    discharged_to_concept_id = "A foreign key identifier to the Concept indicating where the patient was discharged to.",
    discharged_to_source_value = "The source value indicating where the patient was discharged to.",
    preceding_visit_detail_id = "A foreign key identifier to the preceding visit detail record.",
    parent_visit_detail_id = "A foreign key identifier to the parent visit detail record.",
    visit_occurrence_id = "A foreign key identifier to the parent Visit Occurrence record."
  )
);

SELECT
    visit_detail_id::BIGINT,
    person_id::BIGINT,
    visit_detail_concept_id::INT,
    visit_detail_start_date::DATE,
    visit_detail_start_datetime::TIMESTAMP,
    visit_detail_end_date::DATE,
    visit_detail_end_datetime::TIMESTAMP,
    visit_detail_type_concept_id::INT,
    provider_id::BIGINT,
    care_site_id::BIGINT,
    visit_detail_source_value::VARCHAR(50),
    visit_detail_source_concept_id::INT,
    admitted_from_concept_id::INT,
    admitted_from_source_value::VARCHAR(50),
    discharged_to_concept_id::INT,
    discharged_to_source_value::VARCHAR(50),
    preceding_visit_detail_id::BIGINT,
    parent_visit_detail_id::BIGINT,
    visit_occurrence_id::BIGINT
FROM int.visit_detail