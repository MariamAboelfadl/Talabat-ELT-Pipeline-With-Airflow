from airflow import DAG
from datetime import datetime,timedelta
from airflow.providers.postgres.operators.postgres import PostgresOperator


with DAG(
    dag_id="db_creation_dag",
    description="create talabat db",
    start_date= datetime(2025,8,20),
    catchup=False,
    tags=["transaction","db"]
) as dag :
    create_table=PostgresOperator(
        task_id="talabat_create_tables",
        postgres_conn_id ="postgres_conn",
        sql = "sqlscript/talabat_create_tables.sql",
        
    )

    insert_values=PostgresOperator(
        task_id="talabat_insert_values",
        postgres_conn_id ="postgres_conn",
        sql="sqlscript/talabat_insert_values.sql"
    )
    
create_table >> insert_values