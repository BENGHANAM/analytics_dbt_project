# iam.tf complet

# Service Account
resource "google_service_account" "dbt_runner" {
    account_id = "dbt-runner"
    display_name = "dbt Runner Service Account"
    description = "SA pour exécuter dbt sur BigQuery"
}

# Roles BigQuery
resource "google_project_iam_member" "dbt_runner_bq_editor" {
    project = var.project_id
    role = "roles/bigquery.dataEditor"
    member = "serviceAccount:${google_service_account.dbt_runner.email}"
}

resource "google_project_iam_member" "dbt_runner_bq_job_user" {
    project = var.project_id
    role = "roles/bigquery.jobUser"
    member = "serviceAccount:${google_service_account.dbt_runner.email}"
}

resource "google_project_iam_member" "dbt_runner_bq_user" {
    project = var.project_id
    role = "roles/bigquery.user"
    member = "serviceAccount:${google_service_account.dbt_runner.email}"
}