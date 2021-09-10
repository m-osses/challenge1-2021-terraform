
resource "google_project_service" "enable_googleapis_cloudbuild" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
}
