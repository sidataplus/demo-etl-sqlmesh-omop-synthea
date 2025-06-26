AUDIT (
  name person_completeness_measurement,
  dialect duckdb,
  blocking FALSE
);

SELECT
  p.person_id
FROM omop.person AS p
LEFT JOIN omop.MEASUREMENT AS e
  ON p.person_id = e.person_id
WHERE
  e.person_id IS NULL;

AUDIT (
  name measurement_meas_event_field_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.MEAS_EVENT_FIELD_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.MEAS_EVENT_FIELD_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name measurement_meas_event_field_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
LEFT JOIN omop.concept AS c
  ON t.MEAS_EVENT_FIELD_CONCEPT_ID = c.concept_id
WHERE
  NOT t.MEAS_EVENT_FIELD_CONCEPT_ID IS NULL
  AND t.MEAS_EVENT_FIELD_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name measurement_measurement_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID IS NULL;

AUDIT (
  name measurement_measurement_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.MEASUREMENT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.MEASUREMENT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name measurement_measurement_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
JOIN omop.concept AS c
  ON t.MEASUREMENT_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Measurement';

AUDIT (
  name measurement_measurement_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
LEFT JOIN omop.concept AS c
  ON t.MEASUREMENT_CONCEPT_ID = c.concept_id
WHERE
  NOT t.MEASUREMENT_CONCEPT_ID IS NULL
  AND t.MEASUREMENT_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name measurement_measurement_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 0;

AUDIT (
  name measurement_measurement_date_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_DATE IS NULL;

AUDIT (
  name measurement_measurement_date_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.MEASUREMENT_DATE < p.birth_datetime;

AUDIT (
  name measurement_measurement_datetime_after_birth,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
JOIN omop.person AS p
  ON t.person_id = p.person_id
WHERE
  t.MEASUREMENT_DATETIME < p.birth_datetime;

AUDIT (
  name measurement_measurement_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_ID IS NULL;

AUDIT (
  name measurement_measurement_id_is_primary_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  MEASUREMENT_ID,
  COUNT(*)
FROM omop.MEASUREMENT
WHERE
  NOT MEASUREMENT_ID IS NULL
GROUP BY
  MEASUREMENT_ID
HAVING
  COUNT(*) > 1;

AUDIT (
  name measurement_measurement_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.MEASUREMENT_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.MEASUREMENT_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name measurement_measurement_type_concept_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_TYPE_CONCEPT_ID IS NULL;

AUDIT (
  name measurement_measurement_type_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.MEASUREMENT_TYPE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.MEASUREMENT_TYPE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name measurement_measurement_type_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
JOIN omop.concept AS c
  ON t.MEASUREMENT_TYPE_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Type Concept';

AUDIT (
  name measurement_measurement_type_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
LEFT JOIN omop.concept AS c
  ON t.MEASUREMENT_TYPE_CONCEPT_ID = c.concept_id
WHERE
  NOT t.MEASUREMENT_TYPE_CONCEPT_ID IS NULL
  AND t.MEASUREMENT_TYPE_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name measurement_measurement_type_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_TYPE_CONCEPT_ID = 0;

AUDIT (
  name measurement_operator_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.OPERATOR_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.OPERATOR_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name measurement_operator_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
JOIN omop.concept AS c
  ON t.OPERATOR_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Meas Value Operator';

AUDIT (
  name measurement_operator_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
LEFT JOIN omop.concept AS c
  ON t.OPERATOR_CONCEPT_ID = c.concept_id
WHERE
  NOT t.OPERATOR_CONCEPT_ID IS NULL
  AND t.OPERATOR_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name measurement_person_id_is_required,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  PERSON_ID IS NULL;

AUDIT (
  name measurement_person_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.PERSON AS p
  ON c.PERSON_ID = p.PERSON_ID
WHERE
  NOT c.PERSON_ID IS NULL AND p.PERSON_ID IS NULL;

AUDIT (
  name measurement_provider_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.PROVIDER AS p
  ON c.PROVIDER_ID = p.PROVIDER_ID
WHERE
  NOT c.PROVIDER_ID IS NULL AND p.PROVIDER_ID IS NULL;

AUDIT (
  name measurement_unit_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.UNIT_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.UNIT_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name measurement_unit_concept_id_fk_domain,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
JOIN omop.concept AS c
  ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE
  c.domain_id <> 'Unit';

AUDIT (
  name measurement_unit_concept_id_is_standard_valid_concept,
  dialect duckdb,
  blocking FALSE
);

SELECT
  t.*
FROM omop.MEASUREMENT AS t
LEFT JOIN omop.concept AS c
  ON t.UNIT_CONCEPT_ID = c.concept_id
WHERE
  NOT t.UNIT_CONCEPT_ID IS NULL
  AND t.UNIT_CONCEPT_ID <> 0
  AND (
    c.concept_id IS NULL OR c.standard_concept <> 'S' OR NOT c.invalid_reason IS NULL
  );

AUDIT (
  name measurement_unit_concept_id_standard_concept_record_completeness,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  UNIT_CONCEPT_ID = 0;

AUDIT (
  name measurement_unit_source_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.UNIT_SOURCE_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.UNIT_SOURCE_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name measurement_value_as_concept_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.CONCEPT AS p
  ON c.VALUE_AS_CONCEPT_ID = p.CONCEPT_ID
WHERE
  NOT c.VALUE_AS_CONCEPT_ID IS NULL AND p.CONCEPT_ID IS NULL;

AUDIT (
  name measurement_visit_detail_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.VISIT_DETAIL AS p
  ON c.VISIT_DETAIL_ID = p.VISIT_DETAIL_ID
WHERE
  NOT c.VISIT_DETAIL_ID IS NULL AND p.VISIT_DETAIL_ID IS NULL;

AUDIT (
  name measurement_visit_occurrence_id_is_foreign_key,
  dialect duckdb,
  blocking FALSE
);

SELECT
  c.*
FROM omop.MEASUREMENT AS c
LEFT JOIN omop.VISIT_OCCURRENCE AS p
  ON c.VISIT_OCCURRENCE_ID = p.VISIT_OCCURRENCE_ID
WHERE
  NOT c.VISIT_OCCURRENCE_ID IS NULL AND p.VISIT_OCCURRENCE_ID IS NULL;

AUDIT (
  name measurement_3006315_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3006315 AND NOT unit_concept_id IN (8784, 8848, 8961, 9444);

AUDIT (
  name measurement_3004410_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3004410 AND NOT unit_concept_id IN (8554, 8737, 9225, 9579);

AUDIT (
  name measurement_40487382_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 40487382 AND NOT unit_concept_id IN (8784, 8848, 8961, 9444);

AUDIT (
  name measurement_3013721_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3013721 AND NOT unit_concept_id IN (8645, 8923);

AUDIT (
  name measurement_3019198_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3019198 AND NOT unit_concept_id IN (8784, 8848, 8961, 9444);

AUDIT (
  name measurement_3034426_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3034426 AND NOT unit_concept_id IN (8555);

AUDIT (
  name measurement_3043688_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3043688 AND NOT unit_concept_id IN (8713);

AUDIT (
  name measurement_3046485_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3046485 AND NOT unit_concept_id IN (8523, 8554, 8596);

AUDIT (
  name measurement_4216098_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4216098 AND NOT unit_concept_id IN (8784, 8848, 8961, 9444);

AUDIT (
  name measurement_4245152_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4245152 AND NOT unit_concept_id IN (8736, 8753, 9557);

AUDIT (
  name measurement_3006923_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3006923 AND NOT unit_concept_id IN (8645, 8923);

AUDIT (
  name measurement_3021044_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3021044 AND NOT unit_concept_id IN (8837);

AUDIT (
  name measurement_3024171_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3024171 AND NOT unit_concept_id IN (8483, 8541);

AUDIT (
  name measurement_3027114_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3027114 AND NOT unit_concept_id IN (8840);

AUDIT (
  name measurement_40762499_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 40762499 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3000963_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3000963 AND NOT unit_concept_id IN (8636, 8713);

AUDIT (
  name measurement_3001604_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3001604 AND NOT unit_concept_id IN (8848, 8961, 9444);

AUDIT (
  name measurement_3019069_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3019069 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3022509_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3022509 AND NOT unit_concept_id IN (8765);

AUDIT (
  name measurement_3028288_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3028288 AND NOT unit_concept_id IN (8840, 9028);

AUDIT (
  name measurement_4148615_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4148615 AND NOT unit_concept_id IN (8784, 8848, 8961, 8848, 9444);

AUDIT (
  name measurement_44806420_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 44806420 AND NOT unit_concept_id IN (720870, 8795);

AUDIT (
  name measurement_3028437_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3028437 AND NOT unit_concept_id IN (8840, 9028);

AUDIT (
  name measurement_3016991_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3016991 AND NOT unit_concept_id IN (8837);

AUDIT (
  name measurement_3026925_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3026925 AND NOT unit_concept_id IN (8820, 8845);

AUDIT (
  name measurement_3028615_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3028615 AND NOT unit_concept_id IN (8784, 8816, 8848, 8961, 9436, 9444);

AUDIT (
  name measurement_3051205_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3051205 AND NOT unit_concept_id IN (8786);

AUDIT (
  name measurement_4098046_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4098046 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3005131_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3005131 AND NOT unit_concept_id IN (8840, 9028);

AUDIT (
  name measurement_3011163_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3011163 AND NOT unit_concept_id IN (8523, 8529, 8554, 8596, 8606);

AUDIT (
  name measurement_3044491_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3044491 AND NOT unit_concept_id IN (8576, 8840, 9028);

AUDIT (
  name measurement_4017361_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4017361 AND NOT unit_concept_id IN (8753, 8840);

AUDIT (
  name measurement_3006504_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3006504 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3000483_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3000483 AND NOT unit_concept_id IN (8840);

AUDIT (
  name measurement_3033543_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3033543 AND NOT unit_concept_id IN (8523);

AUDIT (
  name measurement_3045716_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3045716 AND NOT unit_concept_id IN (8753, 9557);

AUDIT (
  name measurement_4101713_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4101713 AND NOT unit_concept_id IN (8636, 8736, 8753, 8840);

AUDIT (
  name measurement_4103762_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4103762 AND NOT unit_concept_id IN (8753, 9557);

AUDIT (
  name measurement_3001008_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3001008 AND NOT unit_concept_id IN (8765, 8786, 8889);

AUDIT (
  name measurement_3009744_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3009744 AND NOT unit_concept_id IN (8564, 8636, 8713);

AUDIT (
  name measurement_3013115_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3013115 AND NOT unit_concept_id IN (8848, 8961, 9444);

AUDIT (
  name measurement_3019550_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3019550 AND NOT unit_concept_id IN (8753, 9557);

AUDIT (
  name measurement_3020416_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3020416 AND NOT unit_concept_id IN (44777575, 8734, 8815);

AUDIT (
  name measurement_3035583_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3035583 AND NOT unit_concept_id IN (8786, 8889);

AUDIT (
  name measurement_3035995_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3035995 AND NOT unit_concept_id IN (8645, 8923);

AUDIT (
  name measurement_3038553_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3038553 AND NOT unit_concept_id IN (9531);

AUDIT (
  name measurement_35610320_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 35610320 AND NOT unit_concept_id IN (8876);

AUDIT (
  name measurement_3001490_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3001490 AND NOT unit_concept_id IN (8784, 8848, 8961, 9444);

AUDIT (
  name measurement_4195214_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4195214 AND NOT unit_concept_id IN (8523, 8554, 8596);

AUDIT (
  name measurement_36306178_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 36306178 AND NOT unit_concept_id IN (720870, 8795);

AUDIT (
  name measurement_37393850_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 37393850 AND NOT unit_concept_id IN (8636, 8713, 8554, 8753);

AUDIT (
  name measurement_3004501_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3004501 AND NOT unit_concept_id IN (8840, 8753);

AUDIT (
  name measurement_3008598_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3008598 AND NOT unit_concept_id IN (8817);

AUDIT (
  name measurement_3018010_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3018010 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3022192_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3022192 AND NOT unit_concept_id IN (8840, 8753);

AUDIT (
  name measurement_4151768_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4151768 AND NOT unit_concept_id IN (9448);

AUDIT (
  name measurement_4197602_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4197602 AND NOT unit_concept_id IN (8719, 9040, 9093, 44777578, 8750, 8923, 44777583);

AUDIT (
  name measurement_46236952_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 46236952 AND NOT unit_concept_id IN (720870, 8795);

AUDIT (
  name measurement_3006906_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3006906 AND NOT unit_concept_id IN (8840);

AUDIT (
  name measurement_3007070_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3007070 AND NOT unit_concept_id IN (8840);

AUDIT (
  name measurement_3020460_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3020460 AND NOT unit_concept_id IN (8751, 8840);

AUDIT (
  name measurement_3023314_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3023314 AND NOT unit_concept_id IN (44777604, 8554);

AUDIT (
  name measurement_3035941_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3035941 AND NOT unit_concept_id IN (8564, 9655);

AUDIT (
  name measurement_3037072_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3037072 AND NOT unit_concept_id IN (8840);

AUDIT (
  name measurement_4151358_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4151358 AND NOT unit_concept_id IN (44777604, 8554, 8523);

AUDIT (
  name measurement_4194332_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4194332 AND NOT unit_concept_id IN (8784, 8848, 8961, 9444);

AUDIT (
  name measurement_3001123_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3001123 AND NOT unit_concept_id IN (8583);

AUDIT (
  name measurement_3012888_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3012888 AND NOT unit_concept_id IN (8876);

AUDIT (
  name measurement_3013707_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3013707 AND NOT unit_concept_id IN (8752);

AUDIT (
  name measurement_3037511_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3037511 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3040168_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3040168 AND NOT unit_concept_id IN (8848, 8961, 9444);

AUDIT (
  name measurement_4097430_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4097430 AND NOT unit_concept_id IN (8753, 9557);

AUDIT (
  name measurement_3005424_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3005424 AND NOT unit_concept_id IN (8617);

AUDIT (
  name measurement_3013603_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3013603 AND NOT unit_concept_id IN (8748, 8842);

AUDIT (
  name measurement_3020509_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3020509 AND NOT unit_concept_id IN (8523, 8554, 8596);

AUDIT (
  name measurement_3036277_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3036277 AND NOT unit_concept_id IN (8582, 9327, 9330, 9546);

AUDIT (
  name measurement_4301868_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4301868 AND NOT unit_concept_id IN (8483, 8541, 8581);

AUDIT (
  name measurement_40762636_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 40762636 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_40765040_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 40765040 AND NOT unit_concept_id IN (8842, 8845);

AUDIT (
  name measurement_3024386_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3024386 AND NOT unit_concept_id IN (8583);

AUDIT (
  name measurement_3009201_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3009201 AND NOT unit_concept_id IN (44777578, 8719, 9040, 9093, 8860);

AUDIT (
  name measurement_3024731_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3024731 AND NOT unit_concept_id IN (8583);

AUDIT (
  name measurement_3050479_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3050479 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_4012479_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4012479 AND NOT unit_concept_id IN (8636, 8753, 8840);

AUDIT (
  name measurement_4152194_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4152194 AND NOT unit_concept_id IN (8876);

AUDIT (
  name measurement_37393840_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 37393840 AND NOT unit_concept_id IN (44777604, 8523, 8554);

AUDIT (
  name measurement_3000593_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3000593 AND NOT unit_concept_id IN (8845);

AUDIT (
  name measurement_3002888_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3002888 AND NOT unit_concept_id IN (8583);

AUDIT (
  name measurement_3010910_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3010910 AND NOT unit_concept_id IN (8647, 8785, 8815, 8931);

AUDIT (
  name measurement_3013290_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3013290 AND NOT unit_concept_id IN (8876);

AUDIT (
  name measurement_3027970_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3027970 AND NOT unit_concept_id IN (8636, 8713, 8950);

AUDIT (
  name measurement_4239408_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4239408 AND NOT unit_concept_id IN (8483, 8541, 8581);

AUDIT (
  name measurement_3010813_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3010813 AND NOT unit_concept_id IN (44777588, 8848, 8961, 9444, 8647);

AUDIT (
  name measurement_3023103_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3023103 AND NOT unit_concept_id IN (8753, 9557);

AUDIT (
  name measurement_4030871_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4030871 AND NOT unit_concept_id IN (8734, 8815, 8931, 9444, 9445);

AUDIT (
  name measurement_4154790_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4154790 AND NOT unit_concept_id IN (8876);

AUDIT (
  name measurement_4217013_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4217013 AND NOT unit_concept_id IN (8876);

AUDIT (
  name measurement_3001318_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3001318 AND NOT unit_concept_id IN (8554, 8596);

AUDIT (
  name measurement_3004249_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3004249 AND NOT unit_concept_id IN (8876);

AUDIT (
  name measurement_3009596_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3009596 AND NOT unit_concept_id IN (8576, 8840);

AUDIT (
  name measurement_3025315_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3025315 AND NOT unit_concept_id IN (8739, 9346, 9373, 9529);

AUDIT (
  name measurement_3053283_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3053283 AND NOT unit_concept_id IN (720870, 8795);

AUDIT (
  name measurement_4008265_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4008265 AND NOT unit_concept_id IN (8736, 8753, 8840);

AUDIT (
  name measurement_36303797_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 36303797 AND NOT unit_concept_id IN (720870, 8795);

AUDIT (
  name measurement_37398460_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 37398460 AND NOT unit_concept_id IN (32995, 8645, 8923);

AUDIT (
  name measurement_3013682_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3013682 AND NOT unit_concept_id IN (8840);

AUDIT (
  name measurement_3026361_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3026361 AND NOT unit_concept_id IN (32706, 8785, 8815, 8931);

AUDIT (
  name measurement_3027018_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3027018 AND NOT unit_concept_id IN (8483, 8541);

AUDIT (
  name measurement_4013965_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4013965 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3013429_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3013429 AND NOT unit_concept_id IN (8784, 8816, 8848, 8961, 9436, 9444);

AUDIT (
  name measurement_3023599_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3023599 AND NOT unit_concept_id IN (8583);

AUDIT (
  name measurement_3036588_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3036588 AND NOT unit_concept_id IN (8525);

AUDIT (
  name measurement_4298431_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4298431 AND NOT unit_concept_id IN (8848, 8961, 9444);

AUDIT (
  name measurement_3017732_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3017732 AND NOT unit_concept_id IN (8848, 8961, 9444);

AUDIT (
  name measurement_3024561_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3024561 AND NOT unit_concept_id IN (8636, 8713);

AUDIT (
  name measurement_3034639_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3034639 AND NOT unit_concept_id IN (8713, 8840, 9579, 8923);

AUDIT (
  name measurement_3013650_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3013650 AND NOT unit_concept_id IN (8784, 8848, 8961, 9444);

AUDIT (
  name measurement_3021886_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3021886 AND NOT unit_concept_id IN (8636, 8713, 8950);

AUDIT (
  name measurement_4254663_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4254663 AND NOT unit_concept_id IN (8848, 9444);

AUDIT (
  name measurement_3001420_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3001420 AND NOT unit_concept_id IN (8840);

AUDIT (
  name measurement_3007461_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3007461 AND NOT unit_concept_id IN (8848, 8961, 9444, 32706);

AUDIT (
  name measurement_3012030_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3012030 AND NOT unit_concept_id IN (8564);

AUDIT (
  name measurement_40764999_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 40764999 AND NOT unit_concept_id IN (720870, 8795);

AUDIT (
  name measurement_3008893_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3008893 AND NOT unit_concept_id IN (8817);

AUDIT (
  name measurement_3016723_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3016723 AND NOT unit_concept_id IN (8840, 8749);

AUDIT (
  name measurement_3026910_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3026910 AND NOT unit_concept_id IN (8645, 8923);

AUDIT (
  name measurement_3033575_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3033575 AND NOT unit_concept_id IN (8784, 8816, 8848, 8961, 9436, 9444);

AUDIT (
  name measurement_3041084_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3041084 AND NOT unit_concept_id IN (8848, 8961, 9444);

AUDIT (
  name measurement_4184637_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4184637 AND NOT unit_concept_id IN (8554, 8632, 8737, 9579);

AUDIT (
  name measurement_4313591_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4313591 AND NOT unit_concept_id IN (8483, 8541);

AUDIT (
  name measurement_37393851_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 37393851 AND NOT unit_concept_id IN (8583);

AUDIT (
  name measurement_1619025_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 1619025 AND NOT unit_concept_id IN (720870, 8795);

AUDIT (
  name measurement_3013869_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3013869 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3035472_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3035472 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3039000_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3039000 AND NOT unit_concept_id IN (8753, 9557);

AUDIT (
  name measurement_3000905_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3000905 AND NOT unit_concept_id IN (8816, 8848, 8961, 9436, 9444);

AUDIT (
  name measurement_3015632_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3015632 AND NOT unit_concept_id IN (8753, 9557);

AUDIT (
  name measurement_3032710_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3032710 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_4197971_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4197971 AND NOT unit_concept_id IN (8554, 8632, 8737);

AUDIT (
  name measurement_42869452_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 42869452 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3002109_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3002109 AND NOT unit_concept_id IN (8523, 8596, 8606);

AUDIT (
  name measurement_3004327_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3004327 AND NOT unit_concept_id IN (8784, 8816, 8848, 8961, 9436, 9444);

AUDIT (
  name measurement_3006322_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3006322 AND NOT unit_concept_id IN (586323);

AUDIT (
  name measurement_3008342_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3008342 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3020630_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3020630 AND NOT unit_concept_id IN (8636, 8713);

AUDIT (
  name measurement_3001122_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3001122 AND NOT unit_concept_id IN (8748, 8842);

AUDIT (
  name measurement_3009542_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3009542 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3010189_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3010189 AND NOT unit_concept_id IN (8765, 8786);

AUDIT (
  name measurement_3010457_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3010457 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_4192368_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4192368 AND NOT unit_concept_id IN (8583);

AUDIT (
  name measurement_3014576_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3014576 AND NOT unit_concept_id IN (8753, 9557);

AUDIT (
  name measurement_3024128_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3024128 AND NOT unit_concept_id IN (8840, 8749);

AUDIT (
  name measurement_3018311_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3018311 AND NOT unit_concept_id IN (8523, 8554, 8596);

AUDIT (
  name measurement_3020891_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3020891 AND NOT unit_concept_id IN (586323, 9289);

AUDIT (
  name measurement_3037556_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3037556 AND NOT unit_concept_id IN (8840, 8923);

AUDIT (
  name measurement_37399332_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 37399332 AND NOT unit_concept_id IN (44777578, 9040);

AUDIT (
  name measurement_3011904_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3011904 AND NOT unit_concept_id IN (8840);

AUDIT (
  name measurement_3019897_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3019897 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3025255_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3025255 AND NOT unit_concept_id IN (8786);

AUDIT (
  name measurement_4076704_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4076704 AND NOT unit_concept_id IN (8753, 8840);

AUDIT (
  name measurement_4172647_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4172647 AND NOT unit_concept_id IN (8848, 8961, 9444);

AUDIT (
  name measurement_37393531_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 37393531 AND NOT unit_concept_id IN (32995, 8645, 8923);

AUDIT (
  name measurement_40771529_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 40771529 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3000034_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3000034 AND NOT unit_concept_id IN (8576, 8723, 8751, 8840, 8859, 8636);

AUDIT (
  name measurement_3035124_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3035124 AND NOT unit_concept_id IN (8786, 8889);

AUDIT (
  name measurement_3002030_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3002030 AND NOT unit_concept_id IN (8554, 8848);

AUDIT (
  name measurement_3019170_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3019170 AND NOT unit_concept_id IN (44777578, 8719, 8860, 9040, 9093, 9550);

AUDIT (
  name measurement_3020149_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3020149 AND NOT unit_concept_id IN (8842);

AUDIT (
  name measurement_3022174_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3022174 AND NOT unit_concept_id IN (8647, 8784, 8785, 8848, 8961);

AUDIT (
  name measurement_3024929_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3024929 AND NOT unit_concept_id IN (8816, 8848, 8961, 9436, 9444);

AUDIT (
  name measurement_3049187_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3049187 AND NOT unit_concept_id IN (720870, 8795);

AUDIT (
  name measurement_37398676_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 37398676 AND NOT unit_concept_id IN (8848);

AUDIT (
  name measurement_4112223_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4112223 AND NOT unit_concept_id IN (8523, 8596);

AUDIT (
  name measurement_3017250_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3017250 AND NOT unit_concept_id IN (8576, 8840);

AUDIT (
  name measurement_4191837_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 4191837 AND NOT unit_concept_id IN (8840, 8753);

AUDIT (
  name measurement_3022096_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3022096 AND NOT unit_concept_id IN (8554);

AUDIT (
  name measurement_3034485_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3034485 AND NOT unit_concept_id IN (8523, 8723, 8838, 9017, 9072);

AUDIT (
  name measurement_44790183_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 44790183 AND NOT unit_concept_id IN (720870, 8795);

AUDIT (
  name measurement_3002400_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3002400 AND NOT unit_concept_id IN (8749, 8837);

AUDIT (
  name measurement_3003338_unit,
  dialect duckdb,
  blocking FALSE
);

SELECT
  *
FROM omop.MEASUREMENT
WHERE
  MEASUREMENT_CONCEPT_ID = 3003338 AND NOT unit_concept_id IN (8713, 8753)