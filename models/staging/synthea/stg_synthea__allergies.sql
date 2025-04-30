MODEL (
	name stg.synthea__allergies,
	description "Synthea allergies table",
	kind VIEW,
	columns (
		allergy_start_date date,
		allergy_stop_date date,
		patient_id varchar,
		encounter_id varchar,
		allergy_code varchar,
		allergy_code_system varchar,
		allergy_description varchar,
		allergy_type varchar,
		allergy_category varchar,
		reaction_1_code varchar,
		reaction_1_description varchar,
		reaction_1_severity varchar,
		reaction_2_code varchar,
		reaction_2_description varchar,
		reaction_2_severity varchar
	),
	column_descriptions (
		allergy_start_date = 'The date the allergy was diagnosed.',
		allergy_stop_date = 'The date the allergy ended, if applicable.',
		patient_id = 'The patient ID.',
		encounter_id = 'The encounter ID.',
		allergy_code = 'The allergy code.',
		allergy_code_system = 'The allergy code system.',
		allergy_description = 'The allergy description.',
		allergy_type = 'Identify entry as an allergy or intolerance.',
		allergy_category = 'Identify the allergy category as drug, medication, food, or environment.',
		reaction_1_code = "Optional SNOMED code of the patient's reaction.",
		reaction_1_description = 'Optional description of the Reaction1 SNOMED code.',
		reaction_1_severity = 'Severity of the reaction: MILD, MODERATE, or SEVERE.',
		reaction_2_code = "Optional SNOMED code of the patient's second reaction.",
		reaction_2_description = 'Optional description of the Reaction2 SNOMED code.',
		reaction_2_severity = 'Severity of the second reaction: MILD, MODERATE, or SEVERE.'
	)
);

SELECT 
	START as allergy_start_date,
	STOP as allergy_stop_date,
	PATIENT as patient_id,
	ENCOUNTER as encounter_id,
	CODE as allergy_code,
	SYSTEM as allergy_code_system,
	DESCRIPTION as allergy_description,
	TYPE as allergy_type,
	CATEGORY as allergy_category,
	REACTION1 as reaction_1_code,
	DESCRIPTION1 as reaction_1_description,
	SEVERITY1 as reaction_1_severity,
	REACTION2 as reaction_2_code,
	DESCRIPTION2 as reaction_2_description,
	SEVERITY2 as reaction_2_severity
FROM synthea.allergies;
