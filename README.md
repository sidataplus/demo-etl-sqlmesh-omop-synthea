# Demo ETL Synthea to OMOP with SQLMesh

Quickstart demo to show how to use SQLMesh to ETL Synthea data to OMOP CDM.

Please refer to more information at these links:

- OHDSI APAC 2024 Poster titled [From dbt to SQLMesh: Enhancing OMOP CDM Data Conversion Efficiency](https://www.ohdsi.org/wp-content/uploads/2025/01/20_Nongnaphat-Wongpiyachai_From-dbt-to-SQLMesh.pdf) by Nongnaphat Wongpiyachai, Chinapat Onprasert, Sornchai Manosorn, Natthawut Adulyanukosol
- <https://github.com/sidataplus/demo-etl-sqlmesh-omop>
- <https://github.com/OHDSI/ETL-Synthea> & <https://github.com/OHDSI/dbt-synthea>
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

