MODEL (
  name vocabulary.drug_strength,
  kind SEED (
    path '$root/seeds/vocabulary/drug_strength_seed.csv'
  ),
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
  )
)