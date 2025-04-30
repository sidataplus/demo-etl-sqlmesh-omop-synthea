MODEL (
	name synthea.allergies,
	kind SEED (
		path '$root/seeds/synthea/allergies.csv'
	),
	columns (
		START date,
		STOP date,
		PATIENT varchar,
		ENCOUNTER varchar,
		CODE varchar,
		SYSTEM varchar,
		DESCRIPTION varchar,
		TYPE varchar,
		CATEGORY varchar,
		REACTION1 varchar,
		DESCRIPTION1 varchar,
		SEVERITY1 varchar,
		REACTION2 varchar,
		DESCRIPTION2 varchar,
		SEVERITY2 varchar
	)
);