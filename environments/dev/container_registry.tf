
resource "google_container_registry" "registry" {
  project = var.project_id
  location = var.tf_state_bucket_location

  depends_on = [
    data.terraform_remote_state.project_init.project_service_containerregistry,
  ]

}
