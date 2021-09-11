
provider "google" {
  project = "${var.project_id}"
}

data "terraform_remote_state" "project_init" {
  backend = "gcs"
  config = {
    bucket  = var.tf_state_bucket_name
    prefix  = "terraform/state/project-init"
  }
}
