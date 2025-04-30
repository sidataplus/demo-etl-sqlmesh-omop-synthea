MODEL (
	name synthea.procedures,
	kind SEED (
		path '$root/seeds/synthea/procedures.csv'
	),
	columns (
		START timestamp,
		STOP timestamp,
		PATIENT varchar,
		ENCOUNTER varchar,
		CODE varchar,
		DESCRIPTION varchar,
		BASE_COST float,
		REASONCODE varchar,
		REASONDESCRIPTION varchar
	)
);