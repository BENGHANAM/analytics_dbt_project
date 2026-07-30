import os
from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
#from airflow.utils.dates import days_ago

#Détéction automatique de l'environnement
if os.path.exists("/home/airflow/gcs"):
    DBT_PROJECT_DIR = "home/airflow/dags/dbt/online_retail"
    DBT_PROFILES_DIR = "home/airflow/dags/dbt"
else:
    DBT_PROFILES_DIR = "/opt/airflow/dags/dbt/online_retail"
    DBT_PROFILES_DIR = "/opt/airflow/dags/dbt"

default_args = {
    "owner" : "data-team",
    "retries" : 1,
    "retry_delay" : timedelta(minutes=5),
    "email_on_failure" : False,
    "depends_on_past" : False,
}

with DAG(
    dag_id="dbt_online_retail_pipeline",
    description="Pipeline dbt quotidien -> Bigquery PROD",
    schedule="0 6 * * *",
    start_date=datetime.now() - timedelta(days= 1),
    default_args=default_args,
    catchup=False,
    tags=["dbt", "online_retail", "prod"]
) as dag:
    
    dbt_run = BashOperator(
        task_id="dbt_run_prod",
        bash_command=f"cd {DBT_PROJECT_DIR} && dbt run --target prod --profiles-dir {DBT_PROFILES_DIR}",
    )

    dbt_test = BashOperator(
        task_id="dbt_test_prod",
        bash_command=f"cd {DBT_PROJECT_DIR} && dbt test --target prod --profil-dir {DBT_PROFILES_DIR}",
    )

    def notify_success():
        print(f"Pipeline temriné : {datetime.now()}")
        tables = [
            "dbt_prod_mart.fct_sales",
            "dbt_prod_mart.kpi_sales_overview",
            "dbt_prod_mart.kpi_sales_monthly",
        ]
        for table in tables:
            print(f" ->{table}")

    notify = PythonOperator(
        task_id="notify_success",
        python_callable= notify_success
    )

    dbt_run >> dbt_test >> notify

