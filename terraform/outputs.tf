# outputs.tf

output "dbt_runner_email" {
    description = "Email du service account dbt-runner"
    value = google_service_account.dbt_runner.email
}

output "dbt_prod_mart_id" {
    description = "ID du dataset account dbt-runner"
    value = google_bigquery_dataset.dbt_prod_mart.dataset_id
}

