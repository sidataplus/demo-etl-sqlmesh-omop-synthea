MODEL (
	name vocabulary.concept_class,
	kind SEED (
		path '$root/seeds/vocabulary/concept_class_seed.csv'
	),
	columns (
		concept_class_id VARCHAR,
		concept_class_name VARCHAR,
		concept_class_concept_id INTEGER
	)
);