# variables.tf

variable "project_id" {
    description = "GCP Project ID"
    type = string
    default = "sales-dbt-project"
}

variable "region" {
    description = "GCP Region"
    type = string
    default = "europe-west1"
}

variable "location" {
    description = "Bigquery location"
    type = string
    default = "EU"
}
