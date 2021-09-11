
resource "google_project_service" "enable_googleapis_cloudbuild" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "enable_googleapis_compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "enable_googleapis_iam" {
  project = var.project_id
  service = "iam.googleapis.com"
}

resource "google_project_service" "servicenetworking" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"
}

resource "google_project_service" "enable_googleapis_sqladmin" {
  project = var.project_id
  service = "sqladmin.googleapis.com"
}

resource "google_project_service" "enable_googleapis_containerregistry" {
  project = var.project_id
  service = "containerregistry.googleapis.com"
}

resource "google_project_service" "enable_googleapis_cloudresourcemanager" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "enable_googleapis_container_gke" {
  project = var.project_id
  service = "container.googleapis.com"
}
