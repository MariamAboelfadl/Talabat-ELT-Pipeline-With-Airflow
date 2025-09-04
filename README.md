# Talabat Data Pipeline

This project is designed to showcase **data engineering best practices**, including modular DAG design, task orchestration, and SQL-based transformations.

## 📌 About the Project
This repository demonstrates a **modern ELT data pipeline** built for a simulated food delivery platform (**Talabat**).  
The pipeline moves data from **PostgreSQL → Google Cloud Storage (GCS) → BigQuery**, and then transforms it into **Dimension** and **Fact** tables for analytics — all orchestrated by **Apache Airflow**.



---

## ⚙️ Tech Stack
| Tool/Service    | Purpose |
|-----------------|---------|
| **PostgreSQL**  | Source database (schema + mock data) |
| **Apache Airflow** | Workflow orchestration & scheduling |
| **Google Cloud Storage (GCS)** | Staging layer for extracted data |
| **BigQuery**    | Cloud data warehouse (Dimensions & Facts) |
| **SQL**         | Schema creation, data insertion, and transformations |
| **Docker Compose** | Local environment setup for Airflow & Postgres |


