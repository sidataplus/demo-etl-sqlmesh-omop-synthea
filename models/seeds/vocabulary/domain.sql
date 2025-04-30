MODEL (
	name vocabulary.domain,
	kind SEED (
		path '$root/seeds/vocabulary/domain_seed.csv'
	),
	columns (
		domain_id VARCHAR,
		domain_name VARCHAR,
		domain_concept_id INTEGER
	)
);