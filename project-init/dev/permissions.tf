## Users & project permissions

# TODO: Review Cloudbuild permissions
resource "google_project_iam_member" "cloudbuild_editor_role" {
  project = var.project_id
  role = "roles/editor"
  member = "serviceAccount:${google_project.project.number}@cloudbuild.gserviceaccount.com"
}

# TODO: Downgrade Cloudbuild permissions
resource "google_project_iam_member" "cloudbuild_servicenetworking_admin_role" {
  project = var.project_id
  role = "roles/servicenetworking.networksAdmin"
  member = "serviceAccount:${google_project.project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_project_iam_member" "cloudbuild_secret_versionmanager_role" {
  project = var.project_id
  role = "roles/secretmanager.secretVersionManager"
  member = "serviceAccount:${google_project.project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_project_iam_member" "cloudbuild_secret_versionaccesor_role" {
  project = var.project_id
  role = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_project.project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_project_iam_member" "carolina_viewer_role" {
  project = var.project_id
  role = "roles/viewer"
  member = "user:carogatica.59@gmail.com"
}
