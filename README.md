# Demo ETL Synthea to OMOP with SQLMesh

Quickstart demo to show how to use SQLMesh to ETL Synthea data to OMOP CDM.

NOTICE: This demo heavily reuses code from [dbt-synthea](https://github.com/OHDSI/dbt-synthea) licensed under Apache-2.0 license.

CAUTION: This demo is for educational purpose only. It is not intended to be used in production. Please do not use it in production without proper testing and validation.
It was created for a demonstration in OHDSI APAC Scientific Forum on May 1, 2025 with heavy reliance on VS Code Copilot, so there are many inconsistencies and errors in the code.  


---

![based on true story](/cartoon.png)

What usually happens when we convert Hospital data to OMOP CDM is that we have a team that prepares the mapping document and hands it off to a developer. The developer is then left to figure out how to implement the mapping as ETL (Extract-transform-load) pipelines. This is where the fun begins.

There are many ways to do this ETL. We could custom write code in SQL, R, Python, etc. If budget allows, some may use commercial ETL tools, but oftentimes involves a lot of GUI clicks like Microsoft SSIS.

In the past few years, we have seen a rise of open-source ETL tools like dbt and SQLMesh that simplify the process of building ETL pipelines. They allow us to write SQL code to define the transformation logic and then run it on many database engines. They also provide features like testing, auditing, and documentation to make the process easier.

---

Please refer to more information at these links:

- OHDSI APAC 2024 Poster titled [From dbt to SQLMesh: Enhancing OMOP CDM Data Conversion Efficiency](https://www.ohdsi.org/wp-content/uploads/2025/01/20_Nongnaphat-Wongpiyachai_From-dbt-to-SQLMesh.pdf) by Nongnaphat Wongpiyachai, Chinapat Onprasert, Sornchai Manosorn, Natthawut Adulyanukosol
- <https://github.com/sidataplus/demo-etl-sqlmesh-omop>
- <https://github.com/OHDSI/ETL-Synthea>
- <https://sqlmesh.com> & <https://sqlmesh.readthedocs.io/en/stable/>

## Prerequisites

- Python v3.12+
- [DuckDB v1.2.1+](https://duckdb.org/docs/installation/)

## Part 1: Initiation

1. Create a repository on GitHub or clone this one
2. (Not required but recommended) Create a virtual environment with `python -m venv .env`
3. (Not required but recommended) Activate the virtual environment with `source .env/bin/activate` on macOS/Linux or `.env\Scripts\activate` on Windows
4. Install sqlmesh with `pip install sqlmesh[web]`. By default, it will install SQLMesh with DuckDB support. If you want to use other engines, please refer to the [SQLMesh documentation: Installation](https://sqlmesh.readthedocs.io/en/stable/installation/#install-extras) for more information.
5. (Skip if you already cloned the repo in step 1) Initialize directory with `sqlmesh init duckdb` & Remove .sql files in `audits/`, `models/`, and `tests` directories.
6. (Skip if you already cloned the repo in step 1) In this demo, we will use Synthea data as CSV files from <https://github.com/OHDSI/dbt-synthea/tree/main/seeds> and put them in `seeds/` directory. *In production, we will set SQLMesh to connect to live databases. Please refer to the [SQLMesh documentation: Connections guide](https://sqlmesh.readthedocs.io/en/stable/guides/connections/) for more information.*

## Part 2: Load Synthea data into DuckDB by using Seeds model

For example, to load `seeds/synthea/allergies.csv` into DuckDB

1. Create a new file `models/seeds/synthea/allergies.sql` with the following content:

```sql
MODEL (
 name synthea.allergies,
 kind SEED (
  path '$root/seeds/synthea/allergies.csv'
 )
);
```

Optionally, you can add column names and types to the model. For example, if you want to add column names and types to `synthea.allergies` model, you can use the following code:

```sql
MODEL (
 name synthea.allergies,
 kind SEED (
  path '$root/seeds/synthea/allergies.csv'
 ),
 columns (
  START date,
  STOP date,
  PATIENT varchar,
  ENCOUNTER varchar,
  CODE varchar,
  SYSTEM varchar,
  DESCRIPTION varchar,
  TYPE varchar,
  CATEGORY varchar,
  REACTION1 varchar,
  DESCRIPTION1 varchar,
  SEVERITY1 varchar,
  REACTION2 varchar,
  DESCRIPTION2 varchar,
  SEVERITY2 varchar
 )
);
```

2. Run `sqlmesh plan dev` to apply local changes to the target environment
3. Check the result with `sqlmesh fetchdf "SELECT * FROM synthea.allergies LIMIT 10"` or `duckdb -ui`
4. Generate the rest of SQL models for all seed files. *This may seems laborious in this demo, but, in production, we usually add new data table one by one not all tables at once like this.*
5. Run `sqlmesh plan dev` to apply local changes to the target environment. Once you're happy with the changes, you can run `sqlmesh plan` to apply the changes to the production environment in the same DuckDB instance.

## Part 3: Staging models

In this part, we will create staging models to transform the data from the seed models to the final models. The staging models will be used to clean and prepare the data for the final models. We will take the example scripts from the [dbt-synthea](https://github.com/OHDSI/dbt-synthea/blob/main/models/staging/synthea/stg_synthea__allergies.sql) and convert them to SQLMesh models.

1. Create a new file `models/staging/synthea/stg_synthea__allergies.sql` with the following content :

```sql
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
```

Explanation of the code:

- `MODEL` block: This block defines the model name, description, kind, columns, and column descriptions.
  - The `kind` is set to `VIEW`, which means that the model will created as a view in database.
  - SQLMesh supports other kinds including `FULL` (table), `INCREMENTAL_BY_TIME_RANGE`, `INCREMENTAL_BY_UNIQUE_KEY`, and etc. Incremental load is preferred for large transformation Please refer to the [SQLMesh documentation: Model kinds](https://sqlmesh.readthedocs.io/en/stable/concepts/models/model_kinds/) for more information.
- The `SELECT` statement is used to select the columns from the `synthea.allergies` table and rename them to match the column names in the staging model. The `AS` keyword is used to rename the columns.
  - Unlike dbt, SQLMesh does not need {{ ref() }} function to refer to other models. You can use the model name directly in the SQL statement.

2. We can run `sqlmesh plan dev` like earlier to apply local changes to the target environment, or use `sqlmesh ui` to interactively check the changes and apply them via the web UI.

## Part 4: Intermediate models

We can transform more data from the staging models before loading them into the final models. These transformations usually include data joining, filtering, aggregation, calculation and etc. The coding is similar to the staging models. In this demo, we will introduce the use of macros to reuse the code. Macros are reusable SQL snippets that can be used in multiple models. [SQLMesh supports Jinja macros](https://sqlmesh.readthedocs.io/en/stable/concepts/macros/jinja_macros/), similar to dbt. You can define macros in the `macros/` directory and use them in your models.

1. Create a new file `macros/safe_hash.sql` with the following content:

```sql
{% macro safe_hash(columns) %}
    {% set coalesced_columns = [] %}
    {% for column in columns %}
        {% do coalesced_columns.append("COALESCE(LOWER(" ~ column ~ "), '')") %}
    {% endfor %}
    MD5({{ coalesced_columns | join(' || ') }})
{% endmacro %}

```

This macro takes a list of columns and returns a MD5 hash of the concatenated values of the columns. It uses `COALESCE` to handle null values and `LOWER` to handle case sensitivity.

2. Use the macro in a model. For example, `models/intermediate/int__location.sql`:

```sql
MODEL (
	name int.location,
	description "Location table",
	kind FULL,
	columns (
		location_id int,
		address_1 varchar,
		city varchar,
		state varchar,
		zip varchar,
		county varchar,
		location_source_value varchar
	)
);

JINJA_QUERY_BEGIN;

{% set address_columns = [
    "address_1", 
    "city",
    "state",
    "zip",
    "county"
] %}


WITH unioned_location_sources AS (
	SELECT DISTINCT
		p.patient_address AS address_1
		, p.patient_city AS city
		, s.state_abbreviation AS state
		, p.patient_zip AS zip
		, p.patient_county AS county
	FROM stg.synthea__patients AS p
	LEFT JOIN stg.map__states AS s ON p.patient_state = s.state_name

	UNION

	SELECT DISTINCT
		organization_address AS address_1
		, organization_city AS city
		, organization_state AS state
		, organization_zip AS zip
		, NULL::VARCHAR AS county
	FROM
		stg.synthea__organizations
)
SELECT
	row_number() OVER (ORDER BY state, city, address_1) AS location_id
	, address_1
	, city
	, state
	, zip
	, county
	, {{ safe_hash(address_columns) }} AS location_source_value
FROM unioned_location_sources

JINJA_END;
```


## Part 5: Final OMOP models

In this part, we will create the final models that will be used to load the data into the OMOP CDM. The final models will be used to transform the data from the intermediate models to the OMOP CDM format. We can specify the data types and column descriptions in the model definition. There are many properties that can be specified in the model definition. Please refer to the [SQLMesh documentation: Model configuration](https://sqlmesh.readthedocs.io/en/stable/reference/model_configuration/) for more information. 

For example, `models/omop/person.sql`:

```sql
MODEL (
  name omop.person,
  kind FULL,
  cron '@daily',
  description 'This table serves as the central identity management for all Persons in the database. It contains records that uniquely identify each person or patient, and some demographic information.',
  columns (
    person_id INTEGER,
    gender_concept_id INTEGER,
    year_of_birth INTEGER,
    month_of_birth INTEGER,
    day_of_birth INTEGER,
    birth_datetime TIMESTAMP,
    race_concept_id INTEGER,
    ethnicity_concept_id INTEGER,
    location_id INTEGER,
    provider_id INTEGER,
    care_site_id INTEGER,
    person_source_value VARCHAR(50),
    gender_source_value VARCHAR(50),
    gender_source_concept_id INTEGER,
    race_source_value VARCHAR(50),
    race_source_concept_id INTEGER,
    ethnicity_source_value VARCHAR(50),
    ethnicity_source_concept_id INTEGER
  ),
  column_descriptions (
    person_id = 'A unique identifier for each person.',
    gender_concept_id = 'The gender of the person.',
    year_of_birth = 'The year of birth of the person.',
    month_of_birth = 'The month of birth of the person.',
    day_of_birth = 'The day of birth of the person.',
    birth_datetime = 'The date and time of birth of the person.',
    race_concept_id = 'The race of the person.',
    ethnicity_concept_id = 'The ethnicity of the person.',
    location_id = 'A foreign key to the location record.',
    provider_id = 'A foreign key to the provider record.',
    care_site_id = 'A foreign key to the care site record.',
    person_source_value = 'The source representation of the person identifier.',
    gender_source_value = 'The source representation of the gender.',
    gender_source_concept_id = 'The source concept for gender.',
    race_source_value = 'The source representation of the race.',
    race_source_concept_id = 'The source concept for race.',
    ethnicity_source_value = 'The source representation of the ethnicity.',
    ethnicity_source_concept_id = 'The source concept for ethnicity.'
  ),
  grain (person_id),
  audits (unique_values(columns := (person_id)))
);

SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    location_id,
    provider_id,
    care_site_id,
    person_source_value,
    gender_source_value,
    gender_source_concept_id,
    race_source_value,
    race_source_concept_id,
    ethnicity_source_value,
    ethnicity_source_concept_id
FROM int.person;
```

Notice the `grain` property for primary key and `audits` property for checking the model prior to downstream transformation.

## What's next?

- Change model kind to `INCREMENTAL_BY_TIME_RANGE` or `INCREMENTAL_BY_UNIQUE_KEY` for large transformation
- Add model cron tags and start/end dates to the models
- Add [audits](https://sqlmesh.readthedocs.io/en/stable/concepts/audits) and [tests](https://sqlmesh.readthedocs.io/en/stable/concepts/tests/) to the models 
- Run the models in production with `sqlmesh run`
- [CI/CD with GitHub Actions](https://sqlmesh.readthedocs.io/en/stable/integrations/github/)
- many more...
