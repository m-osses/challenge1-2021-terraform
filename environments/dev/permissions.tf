## Users permissions

resource "google_project_iam_member" "carolina_viewer_role" {
  project = var.project_id
  role = "roles/viewer"
  member = "user:carogatica.59@gmail.com"
}
