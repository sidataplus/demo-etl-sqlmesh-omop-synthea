MODEL (
  name omop.provider,
  description 'The PROVIDER table contains a list of uniquely identified healthcare providers. These are persons or organizations that provide healthcare services.',
  kind FULL,
  columns (
    provider_id BIGINT,
    provider_name TEXT,
    npi TEXT,
    dea TEXT,
    specialty_concept_id INT,
    care_site_id BIGINT,
    year_of_birth INT,
    gender_concept_id INT,
    provider_source_value TEXT,
    specialty_source_value TEXT,
    specialty_source_concept_id INT,
    gender_source_value TEXT,
    gender_source_concept_id INT
  ),
  audits (
    provider_care_site_id_is_foreign_key,
    provider_gender_concept_id_is_foreign_key,
    provider_gender_concept_id_fk_domain,
    provider_gender_concept_id_is_standard_valid_concept,
    provider_gender_concept_id_standard_concept_record_completeness,
    provider_gender_source_concept_id_is_foreign_key,
    provider_provider_id_is_required,
    provider_provider_id_is_primary_key,
    provider_specialty_concept_id_is_foreign_key,
    provider_specialty_concept_id_is_standard_valid_concept,
    provider_specialty_concept_id_standard_concept_record_completeness,
    provider_specialty_source_concept_id_is_foreign_key
  )
);

SELECT
  provider_id,
  provider_name,
  npi,
  dea,
  specialty_concept_id,
  care_site_id,
  year_of_birth,
  gender_concept_id,
  provider_source_value,
  specialty_source_value,
  specialty_source_concept_id,
  gender_source_value,
  gender_source_concept_id
FROM int.provider