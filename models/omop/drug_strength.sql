MODEL (
  name omop.drug_strength,
  kind FULL,
  description "The DRUG_STRENGTH table contains structured content about the amount or concentration and associated units of a specific ingredient contained within a particular drug product.",
  columns (
    drug_concept_id INT,
    ingredient_concept_id INT,
    amount_value FLOAT,
    amount_unit_concept_id INT,
    numerator_value FLOAT,
    numerator_unit_concept_id INT,
    denominator_value FLOAT,
    denominator_unit_concept_id INT,
    box_size INT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason VARCHAR(1)
  ),
  column_descriptions (
    drug_concept_id = 'A foreign key to the Concept representing the Branded Drug or Clinical Drug Product.',
    ingredient_concept_id = 'A foreign key to the Concept representing the active ingredient.',
    amount_value = 'The numeric value of the amount of active ingredient.',
    amount_unit_concept_id = 'A foreign key to the Concept representing the Unit for the amount.',
    numerator_value = 'The concentration value of the active ingredient.',
    numerator_unit_concept_id = 'A foreign key to the Concept representing the Unit for the concentration numerator.',
    denominator_value = 'The amount of the total liquid or other divisible product.',
    denominator_unit_concept_id = 'A foreign key to the Concept representing the Unit for the concentration denominator.',
    box_size = 'The number of units in a package or box.',
    valid_start_date = 'The date when the drug strength record was first recorded.',
    valid_end_date = 'The date when the drug strength record became invalid.',
    invalid_reason = 'Reason the drug strength record was invalidated.'
  )
);

SELECT
    drug_concept_id::INT,
    ingredient_concept_id::INT,
    amount_value::FLOAT,
    amount_unit_concept_id::INT,
    numerator_value::FLOAT,
    numerator_unit_concept_id::INT,
    denominator_value::FLOAT,
    denominator_unit_concept_id::INT,
    box_size::INT,
    valid_start_date::DATE,
    valid_end_date::DATE,
    invalid_reason::VARCHAR(1)
FROM stg.vocabulary__drug_strength