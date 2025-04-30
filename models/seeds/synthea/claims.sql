MODEL (
	name synthea.claims,
	kind SEED (
		path '$root/seeds/synthea/claims.csv'
	),
	columns (
		Id varchar,
		PATIENTID varchar,
		PROVIDERID varchar,
		PRIMARYPATIENTINSURANCEID varchar,
		SECONDARYPATIENTINSURANCEID varchar,
		DEPARTMENTID integer,
		PATIENTDEPARTMENTID integer,
		DIAGNOSIS1 varchar,
		DIAGNOSIS2 varchar,
		DIAGNOSIS3 varchar,
		DIAGNOSIS4 varchar,
		DIAGNOSIS5 varchar,
		DIAGNOSIS6 varchar,
		DIAGNOSIS7 varchar,
		DIAGNOSIS8 varchar,
		REFERRINGPROVIDERID varchar,
		APPOINTMENTID varchar,
		CURRENTILLNESSDATE timestamp,
		SERVICEDATE timestamp,
		SUPERVISINGPROVIDERID varchar,
		STATUS1 varchar,
		STATUS2 varchar,
		STATUSP varchar,
		OUTSTANDING1 float,
		OUTSTANDING2 float,
		OUTSTANDINGP float,
		LASTBILLEDDATE1 timestamp,
		LASTBILLEDDATE2 timestamp,
		LASTBILLEDDATEP timestamp,
		HEALTHCARECLAIMTYPEID1 integer,
		HEALTHCARECLAIMTYPEID2 integer
	)
);