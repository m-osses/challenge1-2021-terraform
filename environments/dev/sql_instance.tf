
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

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
  name             = "master-instance-${random_id.db_name_suffix.hex}"
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

resource "google_sql_database" "challenge_db" {
  name     = "challenge1"
  instance = google_sql_database_instance.master.name
}

resource "random_id" "db_user_password_suffix" {
  byte_length = 8
}


resource "google_sql_user" "challenge1_user" {
  name     = "challenge1"
  instance = google_sql_database_instance.master.name
  password = random_id.db_user_password_suffix.hex
}
