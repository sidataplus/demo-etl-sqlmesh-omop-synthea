MODEL (
	name synthea.observations,
	kind SEED (
		path '$root/seeds/synthea/observations.csv'
	),
	columns (
		DATE timestamp,
		PATIENT varchar,
		ENCOUNTER varchar,
		CATEGORY varchar,
		CODE varchar,
		DESCRIPTION varchar,
		VALUE varchar,
		UNITS varchar,
		TYPE varchar
	)
);