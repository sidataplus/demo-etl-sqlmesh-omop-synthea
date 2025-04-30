MODEL (
	name vocabulary.drug_strength,
	kind SEED (
		path '$root/seeds/vocabulary/drug_strength_seed.csv'
	),
	columns (
		drug_concept_id INTEGER,
		ingredient_concept_id INTEGER,
		amount_value DOUBLE,
		amount_unit_concept_id INTEGER,
		numerator_value DOUBLE,
		numerator_unit_concept_id INTEGER,
		denominator_value DOUBLE,
		denominator_unit_concept_id INTEGER,
		box_size INTEGER,
		valid_start_date DATE,
		valid_end_date DATE,
		invalid_reason VARCHAR
	)
);