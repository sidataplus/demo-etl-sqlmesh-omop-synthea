MODEL (
	name synthea.devices,
	kind SEED (
		path '$root/seeds/synthea/devices.csv'
	),
	columns (
		START timestamp,
		STOP timestamp,
		PATIENT varchar,
		ENCOUNTER varchar,
		CODE varchar,
		DESCRIPTION varchar,
		UDI varchar
	)
);