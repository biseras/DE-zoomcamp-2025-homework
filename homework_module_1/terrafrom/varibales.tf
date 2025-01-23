variable "credentials" {
  description = "My Credentials"
  default     = "my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "123e4567-e89b-12d3-a456"
}

variable "region" {
  description = "Region"
  default     = "europe-west1"
}

variable "location" {
  description = "Project Location"
  default     = "EU"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset_big_query"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "terraform-bucket_123e4567"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}