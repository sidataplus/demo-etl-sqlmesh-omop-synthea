MODEL (
	name synthea.careplans,
	kind SEED (
		path '$root/seeds/synthea/careplans.csv'
	),
	columns (
		Id varchar,
		START date,
		STOP date,
		PATIENT varchar,
		ENCOUNTER varchar,
		CODE varchar,
		DESCRIPTION varchar,
		REASONCODE varchar,
		REASONDESCRIPTION varchar
	)
);