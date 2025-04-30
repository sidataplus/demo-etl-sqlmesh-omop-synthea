MODEL (
	name synthea.imaging_studies,
	kind SEED (
		path '$root/seeds/synthea/imaging_studies.csv'
	),
	columns (
		Id varchar,
		DATE timestamp,
		PATIENT varchar,
		ENCOUNTER varchar,
		SERIES_UID varchar,
		BODYSITE_CODE varchar,
		BODYSITE_DESCRIPTION varchar,
		MODALITY_CODE varchar,
		MODALITY_DESCRIPTION varchar,
		INSTANCE_UID varchar,
		SOP_CODE varchar,
		SOP_DESCRIPTION varchar,
		PROCEDURE_CODE varchar
	)
);