MODEL (
  name omop.measurement,
  kind FULL,
  description "The MEASUREMENT table contains records of Measurements, i.e. structured values obtained through systematic examination or testing.",
  columns (
    measurement_id BIGINT,
    person_id BIGINT,
    measurement_concept_id INT,
    measurement_date DATE,
    measurement_datetime TIMESTAMP,
    measurement_time TEXT,
    measurement_type_concept_id INT,
    operator_concept_id INT,
    value_as_number REAL,
    value_as_concept_id INT,
    unit_concept_id INT,
    range_low REAL,
    range_high REAL,
    provider_id BIGINT,
    visit_occurrence_id BIGINT,
    visit_detail_id BIGINT,
    measurement_source_value TEXT,
    measurement_source_concept_id INT,
    unit_source_value TEXT,
    unit_source_concept_id INT,
    value_source_value TEXT,
    measurement_event_id BIGINT,
    meas_event_field_concept_id INT
  ),
  column_descriptions (measurement_id = 'A unique identifier for each measurement.', person_id = 'A foreign key identifier to the Person who had the measurement taken.', measurement_concept_id = 'A foreign key identifier to the Standard Concept for the measurement.', measurement_date = 'The date when the measurement was taken.', measurement_datetime = 'The date and time when the measurement was taken.', measurement_time = 'The time when the measurement was taken.', measurement_type_concept_id = 'A foreign key identifier to the Concept defining the type of measurement.', operator_concept_id = 'A foreign key identifier to the Concept representing the operator applied to the value.', value_as_number = 'The numeric value of the measurement result.', value_as_concept_id = 'A foreign key identifier to the Concept representing a categorical result.', unit_concept_id = 'A foreign key identifier to the Concept representing the unit of the measurement.', range_low = 'The lower limit of the normal range for the measurement.', range_high = 'The upper limit of the normal range for the measurement.', provider_id = 'A foreign key identifier to the Provider associated with the measurement.', visit_occurrence_id = 'A foreign key identifier to the Visit Occurrence during which the measurement occurred.', visit_detail_id = 'A foreign key identifier to the Visit Detail during which the measurement occurred.', measurement_source_value = 'The source code for the measurement as it appears in the source data.', measurement_source_concept_id = 'A foreign key identifier to a Measurement Concept that refers to the code used in the source.', unit_source_value = 'The source value for the unit.', unit_source_concept_id = 'A foreign key identifier to a Unit Concept that refers to the code used in the source.', value_source_value = 'The source value for the measurement result.', measurement_event_id = 'The primary key of a linked event record.', meas_event_field_concept_id = 'A foreign key identifier to the Concept identifying the table of the linked event.')
);

WITH all_measurements AS (
  SELECT
    *
  FROM int.measurement_observations
  UNION ALL
  SELECT
    *
  FROM int.measurement_procedures
)
SELECT
  ROW_NUMBER() OVER (ORDER BY person_id, measurement_date, measurement_concept_id)::BIGINT AS measurement_id,
  person_id::BIGINT,
  measurement_concept_id::INT,
  measurement_date::DATE,
  measurement_datetime::TIMESTAMP,
  measurement_time::TEXT,
  measurement_type_concept_id::INT,
  operator_concept_id::INT,
  value_as_number::REAL,
  value_as_concept_id::INT,
  unit_concept_id::INT,
  range_low::REAL,
  range_high::REAL,
  provider_id::BIGINT,
  visit_occurrence_id::BIGINT,
  visit_detail_id::BIGINT,
  measurement_source_value::TEXT,
  measurement_source_concept_id::INT,
  unit_source_value::TEXT,
  unit_source_concept_id::INT,
  value_source_value::TEXT,
  measurement_event_id::BIGINT,
  meas_event_field_concept_id::INT
FROM all_measurements