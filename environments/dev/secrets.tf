//resource "google_secret_manager_secret" "sql_user_password" {
//  secret_id = "sql_user_password"
//
//  labels = {
//    label = "postgres"
//  }
//
//  replication {
//    user_managed {
//      replicas {
//        location = "us-central1"
//      }
//    }
//  }
//}
//
//
//resource "google_secret_manager_secret_version" "sql_user_password_version" {
//  secret = google_secret_manager_secret.sql_user_password.id
//  secret_data = google_sql_user.challenge1_user.password
//}
