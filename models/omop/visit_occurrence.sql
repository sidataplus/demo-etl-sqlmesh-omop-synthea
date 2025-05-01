MODEL (
  name omop.visit_occurrence,
  kind FULL,
  description "Contains records corresponding to a Person's interaction with the healthcare system.",
  column_descriptions (visit_occurrence_id = "A unique identifier for each visit occurrence.", person_id = "A foreign key identifier to the Person associated with the visit.", visit_concept_id = "A foreign key identifier to the Standard Concept for the visit type.", visit_start_date = "The start date of the visit.", visit_start_datetime = "The start date and time of the visit.", visit_end_date = "The end date of the visit.", visit_end_datetime = "The end date and time of the visit.", visit_type_concept_id = "A foreign key identifier to the Concept defining the type of visit record.", provider_id = "A foreign key identifier to the Provider associated with the visit.", care_site_id = "A foreign key identifier to the Care Site where the visit occurred.", visit_source_value = "The source value for the visit type.", visit_source_concept_id = "A foreign key identifier to a Concept that refers to the visit source value.", admitted_from_concept_id = "A foreign key identifier to the Concept indicating where the patient was admitted from.", admitted_from_source_value = "The source value indicating where the patient was admitted from.", discharged_to_concept_id = "A foreign key identifier to the Concept indicating where the patient was discharged to.", discharged_to_source_value = "The source value indicating where the patient was discharged to.", preceding_visit_occurrence_id = "A foreign key identifier to the preceding visit occurrence record.")
);

SELECT
  visit_occurrence_id,
  person_id,
  CASE
    WHEN LOWER(visit_class) = 'er+ip'
    THEN 262
    WHEN LOWER(visit_class) IN ('ambulatory', 'wellness', 'outpatient')
    THEN 9202
    WHEN LOWER(visit_class) IN ('emergency', 'urgentcare')
    THEN 9203
    WHEN LOWER(visit_class) = 'inpatient'
    THEN 9201
    ELSE 0
  END AS visit_concept_id,
  visit_start_date,
  NULL::TIMESTAMP AS visit_start_datetime,
  visit_end_date,
  NULL::TIMESTAMP AS visit_end_datetime,
  32827 AS visit_type_concept_id,
  NULL::INT AS provider_id,
  NULL::INT AS care_site_id,
  visit_class AS visit_source_value,
  0 AS visit_source_concept_id,
  0 AS admitted_from_concept_id,
  NULL::TEXT AS admitted_from_source_value,
  0 AS discharged_to_concept_id,
  NULL::TEXT AS discharged_to_source_value,
  NULL::INT AS preceding_visit_occurrence_id
FROM int.visits