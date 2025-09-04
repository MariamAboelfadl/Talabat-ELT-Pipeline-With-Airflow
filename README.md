# Data Pipeline with Airflow, Postgres, GCS, and BigQuery

## 📌 Overview
This project demonstrates a **modern data pipeline** using:
- **Postgres** → Source database with sample data.
- **Google Cloud Storage (GCS)** → Staging layer.
- **BigQuery** → Data warehouse (with Dimensions & Facts).
- **Airflow** → Orchestrator for all pipeline tasks.

The pipeline:
1. Creates tables in Postgres and inserts mock data.
2. Extracts data from Postgres → uploads to GCS.
3. Loads data from GCS → BigQuery (raw tables).
4. Transforms data → inserts into **Dimensions** and **Facts** tables in BigQuery.
5. A master DAG triggers all the above DAGs in sequence.

