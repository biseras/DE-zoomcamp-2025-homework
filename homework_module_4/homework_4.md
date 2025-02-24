Question 1: Understanding dbt model resolution
Provided you've got the following sources.yaml

```python
version: 2

sources:
  - name: raw_nyc_tripdata
    database: "{{ env_var('DBT_BIGQUERY_PROJECT', 'dtc_zoomcamp_2025') }}"
    schema:   "{{ env_var('DBT_BIGQUERY_SOURCE_DATASET', 'raw_nyc_tripdata') }}"
    tables:
      - name: ext_green_taxi
      - name: ext_yellow_taxi
```

with the following env variables setup where dbt runs:

```python
export DBT_BIGQUERY_PROJECT=myproject
export DBT_BIGQUERY_DATASET=my_nyc_tripdata
```
What does this .sql model compile to?

```python
select * 
from {{ source('raw_nyc_tripdata', 'ext_green_taxi' ) }}
```

Answer 1: 
```python
select * from myproject.my_nyc_tripdata.ext_green_taxi
```

---

Question 2: dbt Variables & Dynamic Models
Say you have to modify the following dbt_model (fct_recent_taxi_trips.sql) to enable Analytics Engineers to dynamically control the date range.

In development, you want to process only the last 7 days of trips
In production, you need to process the last 30 days for analytics
```sql
select *
from {{ ref('fact_taxi_trips') }}
where pickup_datetime >= CURRENT_DATE - INTERVAL '30' DAY
```
What would you change to accomplish that in a such way that command line arguments takes precedence over ENV_VARs, which takes precedence over DEFAULT value?
Answer 2:
**Update the WHERE clause to pickup_datetime >= CURRENT_DATE - INTERVAL '{{ var("days_back", env_var("DAYS_BACK", "30")) }}' DAY**

---

Question 3: dbt Data Lineage and Execution
Considering the data lineage below and that taxi_zone_lookup is the only materialization build (from a .csv seed file):

Select the option that does NOT apply for materializing fct_taxi_monthly_zone_revenue:

Answer: **dbt run --select +models/core/dim_taxi_trips.sql+ --target prod**  

---
Question 4: dbt Macros and Jinja
Consider you're dealing with sensitive data (e.g.: PII), that is only available to your team and very selected few individuals, in the raw layer of your DWH (e.g: a specific BigQuery dataset or PostgreSQL schema),

Among other things, you decide to obfuscate/masquerade that data through your staging models, and make it available in a different schema (a staging layer) for other Data/Analytics Engineers to explore

And optionally, yet another layer (service layer), where you'll build your dimension (dim_) and fact (fct_) tables (assuming the Star Schema dimensional modeling) for Dashboarding and for Tech Product Owners/Managers

You decide to make a macro to wrap a logic around it:

```python
{% macro resolve_schema_for(model_type) -%}

    {%- set target_env_var = 'DBT_BIGQUERY_TARGET_DATASET'  -%}
    {%- set stging_env_var = 'DBT_BIGQUERY_STAGING_DATASET' -%}

    {%- if model_type == 'core' -%} {{- env_var(target_env_var) -}}
    {%- else -%}                    {{- env_var(stging_env_var, env_var(target_env_var)) -}}
    {%- endif -%}

{%- endmacro %}
```
And use on your staging, dim_ and fact_ models as:



```python
{{ config(
    schema=resolve_schema_for('core'), 
) }}
```

That all being said, regarding macro above, select all statements that are true to the models using it:

Answer: 
**1.Setting a value for DBT_BIGQUERY_TARGET_DATASET env var is mandatory, or it'll fail to compile**  
**3.When using core, it materializes in the dataset defined in DBT_BIGQUERY_TARGET_DATASET**  
**4.When using stg, it materializes in the dataset defined in DBT_BIGQUERY_STAGING_DATASET, or defaults to DBT_BIGQUERY_TARGET_DATASET**  
**5.When using staging, it materializes in the dataset defined in DBT_BIGQUERY_STAGING_DATASET, or defaults to DBT_BIGQUERY_TARGET_DATASET**  



