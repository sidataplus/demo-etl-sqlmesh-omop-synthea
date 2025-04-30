MODEL (
	name vocabulary.relationship_seed,
	kind SEED (
		path '$root/seeds/vocabulary/relationship_seed.csv'
	),
	columns (
		relationship_id VARCHAR,
		relationship_name VARCHAR,
		is_hierarchical VARCHAR,
		defines_ancestry VARCHAR,
		reverse_relationship_id VARCHAR,
		relationship_concept_id INTEGER
	)
);