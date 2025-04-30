MODEL (
	name synthea.payers,
	kind SEED (
		path '$root/seeds/synthea/payers.csv'
	),
	columns (
		Id varchar,
		NAME varchar,
		ADDRESS varchar,
		CITY varchar,
		STATE_HEADQUARTERED varchar,
		ZIP integer,
		PHONE varchar,
		AMOUNT_COVERED float,
		AMOUNT_UNCOVERED float,
		REVENUE float,
		COVERED_ENCOUNTERS integer,
		UNCOVERED_ENCOUNTERS integer,
		COVERED_MEDICATIONS integer,
		UNCOVERED_MEDICATIONS integer,
		COVERED_PROCEDURES integer,
		UNCOVERED_PROCEDURES integer,
		COVERED_IMMUNIZATIONS integer,
		UNCOVERED_IMMUNIZATIONS integer,
		UNIQUE_CUSTOMERS integer,
		QOLS_AVG float,
		MEMBER_MONTHS integer
	)
);