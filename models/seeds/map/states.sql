MODEL (
	name map.states,
	kind SEED (
		path '$root/seeds/map/states.csv'
	),
	columns (
		state_name varchar,
		state_abbreviation varchar
	)
)