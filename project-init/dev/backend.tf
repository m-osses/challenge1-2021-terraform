terraform {
  backend "gcs" {
    # --- partial config ---
    bucket = "terraform-state-challenge1-dev"
    # credentials = ...
    prefix = "terraform/state/project-init"
  }
}
//
//terraform {
//  backend "local" {}
//}
