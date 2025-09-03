from airflow import DAG
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from datetime import datetime

with DAG(
    dag_id="master_dag",
    start_date=datetime(2025, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["master","control"]
) as dag:

    dags_to_trigger = ["db_creation_dag", "postgres_to_bq","talabat_transformations"]

    trigger_tasks = [
        TriggerDagRunOperator(
            task_id=f"trigger_{dag_id}",
            trigger_dag_id=dag_id,
            wait_for_completion=True
        )
        for dag_id in dags_to_trigger
    ]
    trigger_tasks[0] >> trigger_tasks[1] >> trigger_tasks[2]  # sequential


