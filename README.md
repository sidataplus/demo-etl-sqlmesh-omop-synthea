# Demo ETL Synthea to OMOP with SQLMesh

Quickstart demo to show how to use SQLMesh to ETL Synthea data to OMOP CDM.

NOTICE: This demo heavily reuses code from [dbt-synthea](https://github.com/OHDSI/dbt-synthea) licensed under Apache-2.0 license.

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

### Part 3: Staging models

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
