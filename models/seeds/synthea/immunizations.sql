MODEL (
	name synthea.immunizations,
	kind SEED (
		path '$root/seeds/synthea/immunizations.csv'
	),
	columns (
		DATE timestamp,
		PATIENT varchar,
		ENCOUNTER varchar,
		CODE varchar,
		DESCRIPTION varchar,
		BASE_COST float
	)
);