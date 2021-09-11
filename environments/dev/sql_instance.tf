
resource "google_compute_global_address" "private_ip_postgresql" {
  name          = "google-managed-services-default"
  description   = "IP Range for peer networks."
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 20
  network       = "default"
}

resource "google_service_networking_connection" "cloudsql-postgres-googleapis-com" {
  network                 = "default"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_postgresql.name]
}

resource "google_sql_database_instance" "master" {
  name             = "master-instance"
  database_version = "POSTGRES_12"
  region           = var.region

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
    ip_configuration  {
      ipv4_enabled = true
      require_ssl = false
      private_network = "projects/${var.project_id}/global/networks/default"
    }
  }
}
