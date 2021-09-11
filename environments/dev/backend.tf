
terraform {
  backend "gcs" {
    bucket = "terraform-state-challenge1-dev"
    prefix = "env/dev"
  }
}
