MODEL (
  name stg.vocabulary__drug_strength,
  description "OMOP Drug Strength table",
  kind FULL,
  columns (
    drug_concept_id INT,
    ingredient_concept_id INT,
    amount_value DOUBLE,
    amount_unit_concept_id INT,
    numerator_value DOUBLE,
    numerator_unit_concept_id INT,
    denominator_value DOUBLE,
    denominator_unit_concept_id INT,
    box_size INT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason TEXT
  ),
  column_descriptions (
    drug_concept_id = 'A foreign key to the Concept table for the drug Concept.',
    ingredient_concept_id = 'A foreign key to the Concept table for the ingredient Concept.',
    amount_value = 'The amount value of the ingredient strength.',
    amount_unit_concept_id = 'A foreign key to the Concept table for the unit of the amount value.',
    numerator_value = 'The strength of the drug as a concentration. This value applies to liquids and inhalants.',
    numerator_unit_concept_id = 'A foreign key to the Concept table for the unit of the numerator value.',
    denominator_value = 'The strength of the drug as a concentration. This value applies to liquids and inhalants.',
    denominator_unit_concept_id = 'A foreign key to the Concept table for the unit of the denominator value.',
    box_size = 'The number of units in the drug product, e.g. the number of tablets in a bottle.',
    valid_start_date = 'The date when the Drug Strength record was first recorded.',
    valid_end_date = 'The date when the Drug Strength record became invalid.',
    invalid_reason = 'Reason the Drug Strength record was invalidated. Possible values are D (deleted), U (updated), or empty for valid records.'
  )
);

SELECT
  drug_concept_id::INT AS drug_concept_id,
  ingredient_concept_id::INT AS ingredient_concept_id,
  amount_value::DOUBLE AS amount_value,
  amount_unit_concept_id::INT AS amount_unit_concept_id,
  numerator_value::DOUBLE AS numerator_value,
  numerator_unit_concept_id::INT AS numerator_unit_concept_id,
  denominator_value::DOUBLE AS denominator_value,
  denominator_unit_concept_id::INT AS denominator_unit_concept_id,
  box_size::INT AS box_size,
  valid_start_date::DATE AS valid_start_date,
  valid_end_date::DATE AS valid_end_date,
  invalid_reason::TEXT AS invalid_reason
FROM vocabulary.drug_strength