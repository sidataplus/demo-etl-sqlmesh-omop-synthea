MODEL (
    name stg.vocabulary__drug_strength,
    description "OMOP Drug Strength table",
    kind FULL,
    columns (
        drug_concept_id int,
        ingredient_concept_id int,
        amount_value double,
        amount_unit_concept_id int,
        numerator_value double,
        numerator_unit_concept_id int,
        denominator_value double,
        denominator_unit_concept_id int,
        box_size int,
        valid_start_date date,
        valid_end_date date,
        invalid_reason varchar
    ),
    column_descriptions (
        drug_concept_id = 'A foreign key to the Concept table for the drug Concept.',
        ingredient_concept_id = 'A foreign key to the Concept table for the ingredient Concept.',
        amount_value = 'The amount value of the ingredient strength.',
        amount_unit_concept_id = 'A foreign key to the Concept table for the unit of the amount value.',
        numerator_value = 'The strength of the drug as a concentration. This value applies to liquids and inhalants.',
        numerator_unit_concept_id = 'A foreign key to the Concept table for the unit of the numerator value.',
        denominator_value = 'The strength of the drug as a concentration. This value applies to liquids and inhalants.',
        denominator_unit_concept_id = 'A foreign key to the Concept table for the unit of the denominator value.',
        box_size = 'The number of units in the drug product, e.g. the number of tablets in a bottle.',
        valid_start_date = 'The date when the Drug Strength record was first recorded.',
        valid_end_date = 'The date when the Drug Strength record became invalid.',
        invalid_reason = 'Reason the Drug Strength record was invalidated. Possible values are D (deleted), U (updated), or empty for valid records.'
    )
);

SELECT
    drug_concept_id::int as drug_concept_id,
    ingredient_concept_id::int as ingredient_concept_id,
    amount_value::double as amount_value,
    amount_unit_concept_id::int as amount_unit_concept_id,
    numerator_value::double as numerator_value,
    numerator_unit_concept_id::int as numerator_unit_concept_id,
    denominator_value::double as denominator_value,
    denominator_unit_concept_id::int as denominator_unit_concept_id,
    box_size::int as box_size,
    valid_start_date::date as valid_start_date,
    valid_end_date::date as valid_end_date,
    invalid_reason::varchar as invalid_reason
FROM vocabulary.drug_strength;
