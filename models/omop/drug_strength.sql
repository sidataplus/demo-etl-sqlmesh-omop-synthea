MODEL (
  name omop.drug_strength,
  kind FULL,
  description "The DRUG_STRENGTH table contains structured content about the amount or concentration and associated units of a specific ingredient contained within a particular drug product.",
  columns (
    drug_concept_id INT,
    ingredient_concept_id INT,
    amount_value REAL,
    amount_unit_concept_id INT,
    numerator_value REAL,
    numerator_unit_concept_id INT,
    denominator_value REAL,
    denominator_unit_concept_id INT,
    box_size INT,
    valid_start_date DATE,
    valid_end_date DATE,
    invalid_reason TEXT
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
  ),
  audits (
    drug_strength_amount_unit_concept_id_is_foreign_key,
    drug_strength_denominator_unit_concept_id_is_foreign_key,
    drug_strength_drug_concept_id_is_required,
    drug_strength_drug_concept_id_is_foreign_key,
    drug_strength_drug_concept_id_fk_domain,
    drug_strength_ingredient_concept_id_is_required,
    drug_strength_ingredient_concept_id_is_foreign_key,
    drug_strength_numerator_unit_concept_id_is_foreign_key,
    drug_strength_valid_end_date_is_required,
    drug_strength_valid_start_date_is_required,
    drug_strength_valid_start_date_start_before_end
  )
);

SELECT
  drug_concept_id::INT,
  ingredient_concept_id::INT,
  amount_value::REAL,
  amount_unit_concept_id::INT,
  numerator_value::REAL,
  numerator_unit_concept_id::INT,
  denominator_value::REAL,
  denominator_unit_concept_id::INT,
  box_size::INT,
  valid_start_date::DATE,
  valid_end_date::DATE,
  invalid_reason::TEXT
FROM stg.vocabulary__drug_strength