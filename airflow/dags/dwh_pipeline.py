from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.bash import BashOperator
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.providers.http.hooks.http import HttpHook
from datetime import datetime


AIRBYTE_CONNECTION_ID = "62f26488-7bf7-41de-b22e-bdab753fc5d2"

def trigger_airbyte_sync():
    hook = HttpHook(method="POST", http_conn_id="airbyte_api")
    response = hook.run(
        endpoint="/api/v1/connections/sync",
        headers={"Content-Type": "application/json"},
        data=f'{{"connectionId": "{AIRBYTE_CONNECTION_ID}"}}'
    )
    print(response.text)



with DAG(
    dag_id="pagila_etl_pipeline",
    start_date=datetime(2026, 3, 15),
    schedule=None,
    catchup=False
) as dag:
     
    check_pagila = SQLExecuteQueryOperator(
        task_id="check_pagila_db",
        conn_id="pagila_db",
        sql="SELECT COUNT(*) FROM film;"
    )
    

    trigger_airbyte = PythonOperator(
        task_id="trigger_airbyte_sync",
        python_callable=trigger_airbyte_sync
    )

    # ------------------
    # DBT tasks
    # ------------------
    run_dbt_models = BashOperator(
        task_id="run_dbt_models",
        bash_command="""
        cd /opt/dbt/pagila_analytics
        
        dbt run --profiles-dir /home/airflow/.dbt --target dev
        """
    )


    run_dbt_tests = BashOperator(
        task_id="run_dbt_tests",
        bash_command="""
        cd /opt/dbt/pagila_analytics
        dbt test
        """
    )

    # ------------------
    # Pipeline Order
    # ------------------
    check_pagila >> trigger_airbyte >> run_dbt_models >> run_dbt_tests