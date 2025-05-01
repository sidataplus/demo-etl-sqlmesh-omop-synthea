MODEL (
  name omop.condition_era,
  kind FULL,
  description "A Condition Era is defined as a span of time when the Person is assumed to have a given condition.",
  columns (
    condition_era_id BIGINT,
    person_id BIGINT,
    condition_concept_id INT,
    condition_era_start_date DATE,
    condition_era_end_date DATE,
    condition_occurrence_count INT
  ),
  column_descriptions (condition_era_id = 'A unique identifier for each Condition Era.', person_id = 'A foreign key identifier to the Person who is experiencing the condition.', condition_concept_id = 'A foreign key identifier to the Standard Condition Concept for the condition.', condition_era_start_date = 'The start date for the Condition Era.', condition_era_end_date = 'The end date for the Condition Era.', condition_occurrence_count = 'The number of Condition Occurrences used to construct the Condition Era.')
);

/* Logic adapted from https://github.com/OHDSI/ETL-CMS/blob/master/SQL/create_CDMv5_condition_era.sql */ /* and dbt-synthea/models/omop/condition_era.sql */
WITH cteConditionTarget AS (
  SELECT
    co.condition_occurrence_id,
    co.person_id,
    co.condition_concept_id,
    co.condition_start_date,
    COALESCE(NULLIF(co.condition_end_date, NULL), co.condition_start_date + INTERVAL '1' DAY) AS condition_end_date
  FROM omop.condition_occurrence AS co /* Replaced ref('condition_occurrence') with direct table reference */
) /* Depending on the needs of your data, you can put more filters on to your code. We assign 0 to our unmapped condition_concept_id's,
   * and since we don't want different conditions put in the same era, we put in the filter below.
   */ /* -WHERE condition_concept_id != 0 */, cteEndDates AS (
  SELECT
    person_id,
    condition_concept_id,
    event_date - INTERVAL '30' DAYS AS end_date /* unpad the end date */
  FROM (
    SELECT
      person_id,
      condition_concept_id,
      event_date,
      event_type,
      MAX(start_ordinal) OVER (PARTITION BY person_id, condition_concept_id ORDER BY event_date, event_type ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS start_ordinal, /* this pulls the current START down from the prior rows so that the NULLs from the END DATES will contain a value we can compare with */
      ROW_NUMBER() OVER (PARTITION BY person_id, condition_concept_id ORDER BY event_date, event_type) AS overall_ord /* this re-numbers the inner UNION so all rows are numbered ordered by the event date */
    FROM (
      /* select the start dates, assigning a row number to each */
      SELECT
        person_id,
        condition_concept_id,
        condition_start_date AS event_date,
        -1 AS event_type,
        ROW_NUMBER() OVER (PARTITION BY person_id, condition_concept_id ORDER BY condition_start_date) AS start_ordinal
      FROM cteConditionTarget
      UNION ALL
      /* pad the end dates by 30 to allow a grace period for overlapping ranges. */
      SELECT
        person_id,
        condition_concept_id,
        condition_end_date + INTERVAL '30' DAYS AS event_date,
        1 AS event_type,
        NULL AS start_ordinal
      FROM cteConditionTarget
    ) AS RAWDATA
  ) AS e
  WHERE
    (
      2 * start_ordinal
    ) - overall_ord = 0
), cteConditionEnds AS (
  SELECT
    c.person_id,
    c.condition_concept_id,
    c.condition_start_date,
    MIN(e.end_date) AS era_end_date
  FROM cteConditionTarget AS c
  INNER JOIN cteEndDates AS e
    ON c.person_id = e.person_id
    AND c.condition_concept_id = e.condition_concept_id
    AND c.condition_start_date <= e.end_date
  GROUP BY
    c.condition_occurrence_id /* Corrected GROUP BY from dbt source which was missing this */,
    c.person_id,
    c.condition_concept_id,
    c.condition_start_date
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, condition_concept_id, era_end_date) AS condition_era_id, /* Added condition_concept_id and era_end_date for deterministic ordering */
  person_id,
  condition_concept_id,
  MIN(condition_start_date) AS condition_era_start_date,
  era_end_date::DATE AS condition_era_end_date, /* Replaced dbt.cast */
  COUNT(*) AS condition_occurrence_count
FROM cteConditionEnds
GROUP BY
  person_id,
  condition_concept_id,
  era_end_date