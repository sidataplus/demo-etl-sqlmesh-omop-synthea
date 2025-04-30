MODEL (
	name vocabulary.concept_synonym,
	kind SEED (
		path '$root/seeds/vocabulary/concept_synonym_seed.csv'
	),
	columns (
		concept_id INTEGER,
		concept_synonym_name VARCHAR(1000),
		language_concept_id INTEGER
	)
);