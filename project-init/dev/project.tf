provider "google" {
  version = "~> 3.16"
}

provider "local" {
  version = "~> 1.4"
}

resource "google_project" "project" {
  project_id = var.project_id
  name = var.project_name
  billing_account = var.tf_billing_account
}
