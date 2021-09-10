resource "google_storage_bucket" "tf_state" {
  project = var.project_id
  name = var.tf_state_bucket_name
  location = var.tf_state_bucket_location
  force_destroy = false
  versioning {
    enabled = true
  }
}
