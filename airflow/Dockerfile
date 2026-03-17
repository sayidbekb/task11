FROM apache/airflow:3.1.8

USER root

RUN apt-get update && apt-get install -y curl

USER airflow

RUN pip install --no-cache-dir apache-airflow-providers-postgres \
    apache-airflow-providers-snowflake \
    apache-airflow-providers-http \
    dbt-snowflake \
    apache-airflow-providers-http \
    dbt-core \
    dbt-postgres