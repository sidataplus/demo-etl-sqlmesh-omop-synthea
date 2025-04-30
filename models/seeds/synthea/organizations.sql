MODEL (
	name synthea.organizations,
	kind SEED (
		path '$root/seeds/synthea/organizations.csv'
	),
	columns (
		Id varchar,
		NAME varchar,
		ADDRESS varchar,
		CITY varchar,
		STATE varchar,
		ZIP varchar,
		LAT float,
		LON float,
		PHONE varchar,
		REVENUE float,
		UTILIZATION integer
	)
);