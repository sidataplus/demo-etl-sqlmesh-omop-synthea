MODEL (
	name synthea.conditions,
	kind SEED (
		path '$root/seeds/synthea/conditions.csv'
	),
	columns (
		START date,
		STOP date,
		PATIENT varchar,
		ENCOUNTER varchar,
		CODE varchar,
		DESCRIPTION varchar
	)
);