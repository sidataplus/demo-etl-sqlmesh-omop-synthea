MODEL (
	name vocabulary.vocabulary_seed,
	kind SEED (
		path '$root/seeds/vocabulary/vocabulary_seed.csv'
	),
	columns (
		vocabulary_id VARCHAR,
		vocabulary_name VARCHAR,
		vocabulary_reference VARCHAR,
		vocabulary_version VARCHAR,
		vocabulary_concept_id INTEGER
	)
);