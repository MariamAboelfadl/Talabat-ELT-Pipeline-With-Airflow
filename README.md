# Talabat Data Pipeline

##  About the Project
This project simulates a **modern data engineering pipeline** for a food delivery platform (Talabat).  
It shows how to move data **from Postgres → GCS → BigQuery**, then transform it into **Dimension** and **Fact** tables for analytics — all orchestrated by **Apache Airflow**.

---

##  Tech Stack
| Tool/Service | Purpose |
|--------------|---------|
| **Postgres** | Source database (operational data) |
| **Airflow**  | Workflow orchestration |
| **Google Cloud Storage (GCS)** | Staging layer for extracted data |
| **BigQuery** | Data warehouse (Dimensions & Facts) |
| **SQL** | Schema creation, mock data, transformations |

---

##  Project Structure

dags/
│── db_pipeline.py # Create Postgres tables & insert mock data
│── postgres_to_bq.py # Extract Postgres → Load into BigQuery
│── transformations_pipeline.py # Run BigQuery transformations (dims + facts)
│── master_dag.py # Orchestrates all DAGs
sqlscript/
│── talabat_create_tables.sql
│── talabat_insert_values.sql
│── dim_customer.sql

