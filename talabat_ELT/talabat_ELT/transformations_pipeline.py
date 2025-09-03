import glob
import os
from airflow import DAG
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator
from airflow.utils.task_group import TaskGroup
from datetime import datetime, timedelta


SQL_DIR = r"/opt/airflow/dags/talabat_ELT/sqlscript"

default_args = {
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}

def load_sql(file_path: str) -> str:
    """Read a single SQL file and return its contents"""
    with open(file_path, "r") as f:
        return f.read().strip()


with DAG(
    dag_id="talabat_transformations",
    start_date=datetime(2023, 1, 1),
    schedule_interval=None,   # change to '@daily' if needed
    catchup=False,
    default_args=default_args,
    tags=["talabat", "transformations"],
) as dag:

    # ----------------------
    # Dimension tasks
    # ----------------------
    with TaskGroup("dimensions") as dim_group:
        dim_sql_files = sorted(glob.glob(os.path.join(SQL_DIR, "dim_*.sql")))
        for file_path in dim_sql_files:
            task_id = os.path.basename(file_path).replace(".sql", "")
            BigQueryInsertJobOperator(
                task_id=task_id,
                configuration={
                    "query": {
                        "query": load_sql(file_path),
                        "useLegacySql": False,
                        "multiStatementTransaction": True,
                    }
                },
                gcp_conn_id="google_cloud_default",
            )

    # ----------------------
    # Fact tasks
    # ----------------------
    with TaskGroup("facts") as fact_group:
        fact_sql_files = sorted(glob.glob(os.path.join(SQL_DIR, "fact_*.sql")))
        for file_path in fact_sql_files:
            task_id = os.path.basename(file_path).replace(".sql", "")
            BigQueryInsertJobOperator(
                task_id=task_id,
                configuration={
                    "query": {
                        "query": load_sql(file_path),
                        "useLegacySql": False,
                        "multiStatementTransaction": True,
                    }
                },
                gcp_conn_id="google_cloud_default",
            )

    # enforce ordering
    dim_group >> fact_group
