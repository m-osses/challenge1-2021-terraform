output "project" {
  value = google_project.project
}

output "project_service_containerregistry" {
  value = google_project_service.enable_googleapis_containerregistry
}
