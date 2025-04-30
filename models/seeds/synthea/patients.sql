MODEL (
	name synthea.patients,
	kind SEED (
		path '$root/seeds/synthea/patients.csv'
	),
	columns (
		Id varchar,
		BIRTHDATE date,
		DEATHDATE date,
		SSN varchar,
		DRIVERS varchar,
		PASSPORT varchar,
		PREFIX varchar,
		FIRST varchar,
		LAST varchar,
		SUFFIX varchar,
		MAIDEN varchar,
		MARITAL varchar,
		RACE varchar,
		ETHNICITY varchar,
		GENDER varchar,
		BIRTHPLACE varchar,
		ADDRESS varchar,
		CITY varchar,
		STATE varchar,
		COUNTY varchar,
		ZIP varchar,
		LAT float,
		LON float,
		HEALTHCARE_EXPENSES float,
		HEALTHCARE_COVERAGE float
	)
);