MODEL (
  name omop.concept_class,
  kind FULL,
  description "The CONCEPT_CLASS table includes semantic categories that reference the source structure of each Vocabulary.",
  audits (
    concept_class_concept_class_concept_id_is_required,
    concept_class_concept_class_concept_id_is_foreign_key,
    concept_class_concept_class_id_is_required,
    concept_class_concept_class_id_is_primary_key,
    concept_class_concept_class_name_is_required
  )
);

SELECT
  concept_class_id::TEXT,
  concept_class_name::TEXT,
  concept_class_concept_id::INT
FROM stg.vocabulary__concept_class