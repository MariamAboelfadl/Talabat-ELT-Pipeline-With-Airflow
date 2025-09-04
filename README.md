# 🍴 Talabat Data Pipeline

![Airflow](https://img.shields.io/badge/Airflow-2.x-green?style=flat&logo=apache-airflow) 
![Postgres](https://img.shields.io/badge/Postgres-13-blue?style=flat&logo=postgresql) 
![BigQuery](https://img.shields.io/badge/BigQuery-GCP-orange?style=flat&logo=google-cloud) 
![Python](https://img.shields.io/badge/Python-3.9+-yellow?style=flat&logo=python)


---

## ✨ Introduction
Welcome to the **Talabat Data Pipeline Project** 🚀  

This repository demonstrates how to build a **production-style ELT pipeline** that moves data from an **operational database (Postgres)** into a **cloud data warehouse (BigQuery)**, applies **transformations**, and prepares data for **analytics & reporting**.  

It’s designed as a showcase of **Data Engineering best practices**: modular Airflow DAGs, SQL-driven transformations, and orchestrated workflows.

---

## ⚙️ Tech Stack
| Tool/Service       | Role |
|--------------------|------|
| 🐘 **Postgres**    | Source database with mock transactional data |
| ☁ **GCS**          | Staging layer for raw extracts |
| 📊 **BigQuery**    | Data warehouse (Dimensions & Facts) |
| 🔄 **Airflow**     | Orchestrator for all DAGs |
| 🐳 **Docker**      | Local environment setup |
| 📜 **SQL**         | Schema creation & transformations |

---

## 🗂 Repository Structure
```
dags/
│── db_pipeline.py              # Create Postgres tables + insert mock data
│── postgres_to_bq.py           # Extract Postgres → Load into BigQuery
│── transformations_pipeline.py # Transform raw → dims & facts
│── master_dag.py               # Orchestrates all DAGs
sqlscript/
│── talabat_create_tables.sql
│── talabat_insert_values.sql
│── dim_*.sql
│── fact_*.sql
docker-compose.yaml
requirements.txt
README.md
```

---

## 🚀 Pipeline Overview

### 1️⃣ Database Creation (`db_pipeline.py`)
- Creates Talabat schema in Postgres  
- Inserts **mock orders, customers, restaurants,and so on**  

---

### 2️⃣ Data Movement (`postgres_to_bq.py`)
- Extracts data from Postgres  
- Stages CSVs in **GCS**  
- Loads into BigQuery **raw tables**  

---

### 3️⃣ Transformations (`transformations_pipeline.py`)
- Runs all `dim_*.sql` → **Dimensions**  
- Runs all `fact_*.sql` → **Facts**  
- Organized with **TaskGroups**  
- Order enforced: **Dims → Facts**  

---

### 4️⃣ Orchestration (`master_dag.py`)
- Triggers DAGs **sequentially**:  
  1. `db_creation_dag`  
  2. `postgres_to_bq`  
  3. `talabat_transformations`  

---

## 🛠️ Setup & Run

### 1. Clone Repository
```bash
git clone https://github.com/MariamAboelfadl/Talabat-ELT-Pipeline-With-Airflow.git
cd Talabat-ELT-Pipeline-With-Airflow
```

### 2. Install Requirements
```bash
pip install -r requirements.txt
```

### 3. Start Airflow
```bash
docker-compose up -d
```

### 4. Access Airflow UI
- URL → `http://localhost:8080`  
- Credentials → configured in `docker-compose.yaml`

---

## 📈 Key Learnings
- Build an **end-to-end ELT pipeline**  
- Connect Airflow with **Postgres, GCS, BigQuery**  
- Structure DAGs with **TaskGroups & modular SQL & Master Dag**  
- Transform raw → **analytics-star schema model**  

---

## 🚧 Future Enhancements
- 🔍 Add **data quality checks** (row counts, anomalies)  
- 🏗 Integrate **dbt** for modular transformations   
- 📡 Add **monitoring & alerting** (Airflow SLA)  

