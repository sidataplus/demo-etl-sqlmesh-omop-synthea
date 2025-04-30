MODEL (
	name synthea.medications,
	kind SEED (
		path '$root/seeds/synthea/medications.csv'
	),
	columns (
		START timestamp,
		STOP timestamp,
		PATIENT varchar,
		PAYER varchar,
		ENCOUNTER varchar,
		CODE varchar,
		DESCRIPTION varchar,
		BASE_COST float,
		PAYER_COVERAGE float,
		DISPENSES integer,
		TOTALCOST float,
		REASONCODE varchar,
		REASONDESCRIPTION varchar
	)
);