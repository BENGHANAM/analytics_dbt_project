#Bigquery.tf

# DEV datasets
resource "google_bigquery_dataset" "dbt_dev_staging" {
    dataset_id = "dbt_dev_staging"
    location = var.location
    description = "dbt DEV staging dataset"
}

resource "google_bigquery_dataset" "dbt_dev_mart" {
    dataset_id = "dbt_dev_mart"
    location = var.location
    description = "dbt DEV mart dataset"
}

# PROD datasets
resource "google_bigquery_dataset" "dbt_prod_staging" {
    dataset_id = "dbt_prod_staging"
    location = var.location
    description = "dbt PRD staging dataset"
}

resource "google_bigquery_dataset" "dbt_prod_mart" {
    dataset_id = "dbt_prod_mart"
    location = var.location
    description = "dbt PROD mart dataset"
}
