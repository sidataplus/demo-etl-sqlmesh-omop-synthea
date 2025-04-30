MODEL (
	name synthea.encounters,
	kind SEED (
		path '$root/seeds/synthea/encounters.csv'
	),
	columns (
		Id varchar,
		START timestamp,
		STOP timestamp,
		PATIENT varchar,
		ORGANIZATION varchar,
		PROVIDER varchar,
		PAYER varchar,
		ENCOUNTERCLASS varchar,
		CODE varchar,
		DESCRIPTION varchar,
		BASE_ENCOUNTER_COST float,
		TOTAL_CLAIM_COST float,
		PAYER_COVERAGE float,
		REASONCODE varchar,
		REASONDESCRIPTION varchar
	)
);