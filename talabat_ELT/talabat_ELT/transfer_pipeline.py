from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.google.cloud.transfers.postgres_to_gcs import PostgresToGCSOperator
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from datetime import datetime

BUCKET = "bucket-talabat"
PROJECT = "ready-de27"
DATASET = "talabat_dataset"

TABLES = [
    "users",
    "restaurants",
    "products",
    "drivers",
    "orders",
    "order_items",
    "payments",
    "reviews"
]

with DAG(
    dag_id="postgres_to_bq",
    start_date=datetime(2025, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["transfer","full"]
) as dag:

    # Task 1: Export all tables to GCS
    def export_all(**context):
        ds = context['ds'] 
        for table in TABLES:
            operator = PostgresToGCSOperator(
                task_id=f"export_{table}_tmp",
                postgres_conn_id="postgres_conn",
                sql=f"SELECT * FROM {table};",
                bucket=BUCKET,
                filename=f"talabat/{table}/{ds}.json",
                export_format="json",
                gcp_conn_id="google_cloud_default"
            )
            operator.execute(context=context)

    export_task = PythonOperator(
        task_id="export_all_tables_to_gcs",
        python_callable=export_all,
        provide_context=True
    )

    # Task 2: Load all tables from GCS to BigQuery
    def load_all(**context):
        ds = context['ds'] 
        for table in TABLES:
            operator = GCSToBigQueryOperator(
                task_id=f"load_{table}_tmp",
                bucket=BUCKET,
                source_objects=[f"talabat/{table}/{ds}.json"],
                destination_project_dataset_table=f"{PROJECT}.{DATASET}.{table}",
                source_format="NEWLINE_DELIMITED_JSON",
                write_disposition="WRITE_TRUNCATE",
                gcp_conn_id="google_cloud_default"
            )
            operator.execute(context=context)

    load_task = PythonOperator(
        task_id="load_all_tables_to_bq",
        python_callable=load_all,
        provide_context=True
    )
    export_task >> load_task

