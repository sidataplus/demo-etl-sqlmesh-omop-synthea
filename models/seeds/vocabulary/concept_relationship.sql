MODEL (
	name vocabulary.concept_relationship,
	kind SEED (
		path '$root/seeds/vocabulary/concept_relationship_seed.csv'
	),
	columns (
		concept_id_1 INTEGER,
		concept_id_2 INTEGER,
		relationship_id VARCHAR,
		valid_start_date DATE,
		valid_end_date DATE,
		invalid_reason VARCHAR
	)
);