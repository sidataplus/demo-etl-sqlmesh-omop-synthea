AUDIT (
  name person_completeness_procedure_occurrence,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.PROCEDURE_OCCURRENCE AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name procedure_occurrence_modifier_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROCEDURE_OCCURRENCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.MODIFIER_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.MODIFIER_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name procedure_occurrence_modifier_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
LEFT JOIN omop.concept AS c
  ON t.MODIFIER_CONCEPT_ID = c.concept_id
WHERE
  NOT t.MODIFIER_CONCEPT_ID IS NULL
  AND t.MODIFIER_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name procedure_occurrence_modifier_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  MODIFIER_CONCEPT_ID = 0;

AUDIT (
  name procedure_occurrence_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name procedure_occurrence_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROCEDURE_OCCURRENCE AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name procedure_occurrence_procedure_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  PROCEDURE_CONCEPT_ID IS NULL;

AUDIT (
  name procedure_occurrence_procedure_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROCEDURE_OCCURRENCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.PROCEDURE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.PROCEDURE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name procedure_occurrence_procedure_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.concept AS c
  ON t.PROCEDURE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Procedure';

AUDIT (
  name procedure_occurrence_procedure_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
LEFT JOIN omop.concept AS c
  ON t.PROCEDURE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.PROCEDURE_CONCEPT_ID IS NULL
  AND t.PROCEDURE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name procedure_occurrence_procedure_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  PROCEDURE_CONCEPT_ID = 0;

AUDIT (
  name procedure_occurrence_procedure_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  PROCEDURE_DATE IS NULL;

AUDIT (
  name procedure_occurrence_procedure_date_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  PROCEDURE_DATE > PROCEDURE_END_DATE;

AUDIT (
  name procedure_occurrence_procedure_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_DATE < p.birth_datetime;

AUDIT (
  name procedure_occurrence_procedure_datetime_start_before_end,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  PROCEDURE_DATETIME > PROCEDURE_END_DATETIME;

AUDIT (
  name procedure_occurrence_procedure_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_DATETIME < p.birth_datetime;

AUDIT (
  name procedure_occurrence_procedure_end_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_END_DATE < p.birth_datetime;

AUDIT (
  name procedure_occurrence_procedure_end_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_END_DATETIME < p.birth_datetime;

AUDIT (
  name procedure_occurrence_procedure_occurrence_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  PROCEDURE_OCCURRENCE_ID IS NULL;

AUDIT (
  name procedure_occurrence_procedure_occurrence_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  PROCEDURE_OCCURRENCE_ID,
  COUNT(*)
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  NOT PROCEDURE_OCCURRENCE_ID IS NULL
GROUP BY
  PROCEDURE_OCCURRENCE_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name procedure_occurrence_procedure_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROCEDURE_OCCURRENCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.PROCEDURE_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.PROCEDURE_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name procedure_occurrence_procedure_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  PROCEDURE_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name procedure_occurrence_procedure_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROCEDURE_OCCURRENCE AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.PROCEDURE_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.PROCEDURE_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name procedure_occurrence_procedure_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.concept AS c
  ON t.PROCEDURE_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name procedure_occurrence_procedure_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
LEFT JOIN omop.concept AS c
  ON t.PROCEDURE_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.PROCEDURE_TYPE_CONCEPT_ID IS NULL
  AND t.PROCEDURE_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name procedure_occurrence_procedure_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.PROCEDURE_OCCURRENCE
WHERE
  PROCEDURE_TYPE_CONCEPT_ID = 0;

AUDIT (
  name procedure_occurrence_provider_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROCEDURE_OCCURRENCE AS c
LEFT JOIN omop.PROVIDER AS p
  ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE
  NOT c.PROVIDER_ID IS NULL AND p.PROVIDER_ID IS NULL;

AUDIT (
  name procedure_occurrence_visit_detail_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROCEDURE_OCCURRENCE AS c
LEFT JOIN omop.VISIT_DETAIL AS p
  ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE
  NOT c.VISIT_DETAIL_ID IS NULL AND p.VISIT_DETAIL_ID IS NULL;

AUDIT (
  name procedure_occurrence_visit_occurrence_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.PROCEDURE_OCCURRENCE AS c
LEFT JOIN omop.VISIT_OCCURRENCE AS p
  ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE
  NOT c.VISIT_OCCURRENCE_ID IS NULL AND p.VISIT_OCCURRENCE_ID IS NULL;

AUDIT (
  name procedure_occurrence_2003947_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2003947 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2003966_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2003966 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2003983_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2003983 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2004031_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004031 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2004063_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004063 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2004070_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004070 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2004090_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004090 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2004164_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004164 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2004263_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004263 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2004329_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004329 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2004342_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004342 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2004443_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004443 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2004627_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2004627 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2109825_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109825 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2109833_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109833 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2109900_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109900 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2109902_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109902 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2109905_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109905 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2109906_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109906 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2109916_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109916 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2109968_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109968 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2109973_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109973 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2109981_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2109981 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2110004_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110004 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2110011_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110011 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2110026_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110026 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2110039_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110039 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2110044_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110044 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2110078_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110078 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110116_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110116 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110142_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110142 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110144_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110144 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110169_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110169 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110175_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110175 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110194_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110194 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110195_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110195 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110203_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110203 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110222_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110222 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110227_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110227 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110230_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110230 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110307_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110307 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110315_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110315 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110316_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110316 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110317_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110317 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2110326_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2110326 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2211747_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2211747 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2211749_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2211749 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2211751_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2211751 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2211753_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2211753 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2211755_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2211755 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2211756_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2211756 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2211757_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2211757 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2211765_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2211765 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2211769_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2211769 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2617204_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2617204 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2721063_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2721063 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2721064_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2721064 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_2780478_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2780478 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_2780523_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 2780523 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4021531_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4021531 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4032622_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4032622 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4038747_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4038747 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4052532_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4052532 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4058792_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4058792 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4073700_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4073700 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4083772_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4083772 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4096783_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4096783 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4127886_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4127886 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4138738_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4138738 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4141940_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4141940 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4146777_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4146777 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4161944_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4161944 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4181912_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4181912 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4234536_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4234536 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4238715_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4238715 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4243919_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4243919 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4275113_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4275113 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4294805_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4294805 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4306780_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4306780 AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4310552_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4310552 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4321575_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4321575 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4330583_gender,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID = 4330583 AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4041261_gender_desc,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID IN (
      SELECT
        descendant_concept_id
      FROM omop.concept_ancestor
      WHERE
        ancestor_concept_id = 4041261
  )
  AND p.gender_concept_id <> 8532;

AUDIT (
  name procedure_occurrence_4250917_gender_desc,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID IN (
      SELECT
        descendant_concept_id
      FROM omop.concept_ancestor
      WHERE
        ancestor_concept_id = 4250917
  )
  AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4077750_gender_desc,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID IN (
      SELECT
        descendant_concept_id
      FROM omop.concept_ancestor
      WHERE
        ancestor_concept_id = 4077750
  )
  AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4043199_gender_desc,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID IN (
      SELECT
        descendant_concept_id
      FROM omop.concept_ancestor
      WHERE
        ancestor_concept_id = 4043199
  )
  AND p.gender_concept_id <> 8507;

AUDIT (
  name procedure_occurrence_4040577_gender_desc,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.PROCEDURE_OCCURRENCE AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.PROCEDURE_CONCEPT_ID IN (
      SELECT
        descendant_concept_id
      FROM omop.concept_ancestor
      WHERE
        ancestor_concept_id = 4040577
  )
  AND p.gender_concept_id <> 8507