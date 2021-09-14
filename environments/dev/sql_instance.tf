
resource "google_compute_global_address" "sql_private_ip_address" {
  provider = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = "default"
}

resource "google_service_networking_connection" "sql_private_vpc_connection" {
  provider = google-beta

  network                 = "default"
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.sql_private_ip_address.name]
}

resource "random_id" "db_instance_name_suffix" {
  byte_length = 5
}

resource "google_sql_database_instance" "master" {
  name             = "master-instance-${random_id.db_instance_name_suffix.hex}"
  database_version = "POSTGRES_12"
  region           = var.region


  depends_on = [google_service_networking_connection.sql_private_vpc_connection]

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
