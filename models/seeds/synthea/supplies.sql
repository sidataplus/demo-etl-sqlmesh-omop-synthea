MODEL (
	name synthea.supplies,
	kind SEED (
		path '$root/seeds/synthea/supplies.csv'
	),
	columns (
		DATE date,
		PATIENT varchar,
		ENCOUNTER varchar,
		CODE varchar,
		DESCRIPTION varchar,
		QUANTITY integer
	)
);