MODEL (
	name vocabulary.concept,
	kind SEED (
		path '$root/seeds/vocabulary/concept_seed.csv'
	),
	columns (
		concept_id INTEGER,
		concept_name VARCHAR,
		domain_id VARCHAR,
		vocabulary_id VARCHAR,
		concept_class_id VARCHAR,
		standard_concept VARCHAR,
		concept_code VARCHAR,
		valid_start_date DATE,
		valid_end_date DATE,
		invalid_reason VARCHAR
	)
);