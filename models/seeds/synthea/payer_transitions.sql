MODEL (
	name synthea.payer_transitions,
	kind SEED (
		path '$root/seeds/synthea/payer_transitions.csv'
	),
	columns (
		PATIENT varchar,
		MEMBERID varchar,
		START_YEAR timestamp,
		END_YEAR timestamp,
		PAYER varchar,
		SECONDARY_PAYER varchar,
		OWNERSHIP varchar,
		OWNERNAME varchar
	)
);