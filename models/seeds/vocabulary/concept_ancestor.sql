MODEL (
	name vocabulary.concept_ancestor,
	kind SEED (
		path '$root/seeds/vocabulary/concept_ancestor_seed.csv'
	),
	columns (
		ancestor_concept_id INTEGER,
		descendant_concept_id INTEGER,
		min_levels_of_separation INTEGER,max_levels_of_separation INTEGER
	)
);