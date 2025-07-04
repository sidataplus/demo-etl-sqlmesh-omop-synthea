MODEL (
  name omop.drug_era,
  kind FULL,
  description "A Drug Era is defined as a span of time when the Person is assumed to be exposed to a particular active ingredient.",
  columns (
    drug_era_id BIGINT,
    person_id BIGINT,
    drug_concept_id INT,
    drug_era_start_date DATE,
    drug_era_end_date DATE,
    drug_exposure_count INT,
    gap_days INT
  ),
  column_descriptions (
    drug_era_id = 'A unique identifier for each Drug Era.',
    person_id = 'A foreign key identifier to the Person.',
    drug_concept_id = 'A foreign key identifier to the Drug Concept representing the ingredient.',
    drug_era_start_date = 'The start date of the Drug Era.',
    drug_era_end_date = 'The end date of the Drug Era.',
    drug_exposure_count = 'The number of drug exposure events contributing to the era.',
    gap_days = 'The number of days allowed between exposures to merge them into a single era.'
  ),
  audits (
    person_completeness_drug_era,
    drug_era_drug_concept_id_is_required,
    drug_era_drug_concept_id_is_foreign_key,
    drug_era_drug_concept_id_fk_domain,
    drug_era_drug_concept_id_is_standard_valid_concept,
    drug_era_drug_concept_id_standard_concept_record_completeness,
    drug_era_drug_era_end_date_is_required,
    drug_era_drug_era_end_date_after_birth,
    drug_era_drug_era_id_is_required,
    drug_era_drug_era_id_is_primary_key,
    drug_era_drug_era_start_date_is_required,
    drug_era_drug_era_start_date_start_before_end,
    drug_era_drug_era_start_date_after_birth,
    drug_era_person_id_is_required,
    drug_era_person_id_is_foreign_key
  )
);

/* Logic adapted from dbt-synthea/models/omop/drug_era.sql */ /* Original source: https://github.com/OHDSI/ETL-CMS/blob/master/SQL/create_CDMv5_drug_era_non_stockpile.sql */
WITH ctePreDrugTarget AS (
    /* Normalize DRUG_EXPOSURE_END_DATE to either the existing drug exposure end date, or add days supply, or add 1 day to the start date */
    SELECT
      d.drug_exposure_id,
      d.person_id,
      c.concept_id AS ingredient_concept_id,
      d.drug_exposure_start_date,
      d.days_supply,
      COALESCE(
        NULLIF(d.drug_exposure_end_date, NULL),
        NULLIF(d.drug_exposure_start_date + /* dbt.dateadd equivalent */ INTERVAL (
          d.days_supply
        ) DAY, d.drug_exposure_start_date),
        d.drug_exposure_start_date + INTERVAL '1' DAY
      ) AS drug_exposure_end_date
    FROM omop.drug_exposure AS d /* SQLMesh: Replaced ref('drug_exposure') */
    INNER JOIN stg.vocabulary__concept_ancestor AS ca /* SQLMesh: Replaced ref('stg_vocabulary__concept_ancestor') */
      ON d.drug_concept_id = ca.descendant_concept_id
    INNER JOIN stg.vocabulary__concept AS c /* SQLMesh: Replaced ref('stg_vocabulary__concept') */
      ON ca.ancestor_concept_id = c.concept_id
    WHERE
      c.vocabulary_id = 'RxNorm' AND c.concept_class_id = 'Ingredient' AND d.drug_concept_id <> 0 AND COALESCE(d.days_supply, 0) >= 0
), cteSubExposureEndDates AS (
    SELECT
      person_id,
      ingredient_concept_id,
      event_date AS end_date
    FROM (
        SELECT
          person_id,
          ingredient_concept_id,
          event_date,
          event_type,
          MAX(start_ordinal) OVER (PARTITION BY person_id, ingredient_concept_id ORDER BY event_date, event_type ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS start_ordinal,
          ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id ORDER BY event_date, event_type) AS overall_ord
        FROM (
            SELECT
              person_id,
              ingredient_concept_id,
              drug_exposure_start_date AS event_date,
              -1 AS event_type,
              ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id ORDER BY drug_exposure_start_date) AS start_ordinal
            FROM ctePreDrugTarget
            UNION ALL
            SELECT
              person_id,
              ingredient_concept_id,
              drug_exposure_end_date,
              1 AS event_type,
              NULL AS start_ordinal
            FROM ctePreDrugTarget
        ) AS RAWDATA
    ) AS e
    WHERE
      (
        2 * start_ordinal
      ) - overall_ord = 0
), cteDrugExposureEnds AS (
    SELECT
      dt.person_id,
      dt.ingredient_concept_id,
      dt.drug_exposure_start_date,
      MIN(e.end_date) AS drug_sub_exposure_end_date
    FROM ctePreDrugTarget AS dt
    INNER JOIN cteSubExposureEndDates AS e
      ON dt.person_id = e.person_id AND dt.ingredient_concept_id = e.ingredient_concept_id AND dt.drug_exposure_start_date <= e.end_date
    GROUP BY
      dt.drug_exposure_id,
      dt.person_id,
      dt.ingredient_concept_id,
      dt.drug_exposure_start_date
), cteSubExposures AS (
    SELECT
      ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id, drug_sub_exposure_end_date ORDER BY person_id) AS row_number,
      person_id,
      ingredient_concept_id,
      MIN(drug_exposure_start_date) AS drug_sub_exposure_start_date,
      drug_sub_exposure_end_date,
      COUNT(*) AS drug_exposure_count
    FROM cteDrugExposureEnds
    GROUP BY
      person_id,
      ingredient_concept_id,
      drug_sub_exposure_end_date
), cteFinalTarget AS (
    SELECT
      row_number,
      person_id,
      ingredient_concept_id,
      drug_sub_exposure_start_date,
      drug_sub_exposure_end_date,
      drug_exposure_count,
      DATE_DIFF('DAY', drug_sub_exposure_start_date, drug_sub_exposure_end_date) AS days_exposed /* dbt.datediff equivalent */
    FROM cteSubExposures
), cteEndDates AS (
    SELECT
      person_id,
      ingredient_concept_id,
      event_date - INTERVAL '30' DAY AS end_date /* Standard SQL interval subtraction */
    FROM (
        SELECT
          person_id,
          ingredient_concept_id,
          event_date,
          event_type,
          MAX(start_ordinal) OVER (PARTITION BY person_id, ingredient_concept_id ORDER BY event_date, event_type ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS start_ordinal,
          ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id ORDER BY event_date, event_type) AS overall_ord
        FROM (
            SELECT
              person_id,
              ingredient_concept_id,
              drug_sub_exposure_start_date AS event_date,
              -1 AS event_type,
              ROW_NUMBER() OVER (PARTITION BY person_id, ingredient_concept_id ORDER BY drug_sub_exposure_start_date) AS start_ordinal
            FROM cteFinalTarget
            UNION ALL
            SELECT
              person_id,
              ingredient_concept_id,
              drug_sub_exposure_end_date + INTERVAL '30' DAY AS event_date, /* Standard SQL interval addition */
              1 AS event_type,
              NULL AS start_ordinal
            FROM cteFinalTarget
        ) AS RAWDATA
    ) AS e
    WHERE
      (
        2 * start_ordinal
      ) - overall_ord = 0
), cteDrugEraEnds AS (
    SELECT
      ft.person_id,
      ft.ingredient_concept_id AS drug_concept_id,
      ft.drug_sub_exposure_start_date,
      MIN(e.end_date) AS drug_era_end_date,
      ft.drug_exposure_count,
      ft.days_exposed
    FROM cteFinalTarget AS ft
    INNER JOIN cteEndDates AS e
      ON ft.person_id = e.person_id AND ft.ingredient_concept_id = e.ingredient_concept_id AND ft.drug_sub_exposure_start_date <= e.end_date
    GROUP BY
      ft.person_id,
      ft.ingredient_concept_id,
      ft.drug_sub_exposure_start_date,
      ft.drug_exposure_count,
      ft.days_exposed
), cteDrugEra AS (
    SELECT
      ROW_NUMBER() OVER (ORDER BY person_id) AS drug_era_id,
      person_id,
      drug_concept_id,
      MIN(drug_sub_exposure_start_date) AS drug_era_start_date,
      drug_era_end_date::DATE AS drug_era_end_date, /* dbt.cast equivalent */
      SUM(drug_exposure_count) AS drug_exposure_count,
      MIN(drug_sub_exposure_start_date) AS min_drug_sub_exposure_start_date,
      SUM(days_exposed) AS sum_days_exposed
    FROM cteDrugEraEnds
    GROUP BY
      person_id,
      drug_concept_id,
      drug_era_end_date
)
SELECT
  drug_era_id,
  person_id,
  drug_concept_id,
  drug_era_start_date,
  drug_era_end_date,
  drug_exposure_count,
  DATE_DIFF('DAY', min_drug_sub_exposure_start_date::DATE /* dbt.cast equivalent */, drug_era_end_date::DATE /* dbt.cast equivalent */) - sum_days_exposed AS gap_days
FROM cteDrugEra