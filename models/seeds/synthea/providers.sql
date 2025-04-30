MODEL (
	name synthea.providers,
	kind SEED (
		path '$root/seeds/synthea/providers.csv'
	),
	columns (
		Id varchar,
		ORGANIZATION varchar,
		NAME varchar,
		GENDER varchar,
		SPECIALITY varchar,
		ADDRESS varchar,
		CITY varchar,
		STATE varchar,
		ZIP varchar,
		LAT float,
		LON float,
		UTILIZATION integer
	)
);