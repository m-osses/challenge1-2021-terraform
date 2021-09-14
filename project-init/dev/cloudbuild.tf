resource "google_cloudbuild_trigger" "github_terraform_main_push_trigger" {
  name = "terraform-main"
  project  = var.project_id
  github {
    owner = "m0-2s-es"
    name = "challenge1-2021-terraform"

    push {
      branch = "main"
    }
  }
  filename = "cloudbuild-pr.yaml"
}

resource "google_cloudbuild_trigger" "github_terraform_dev_push_trigger" {
  name = "terraform-dev"
  project  = var.project_id
  github {
    owner = "m0-2s-es"
    name = "challenge1-2021-terraform"

    push {
      branch = "dev"
    }
  }
  filename = "cloudbuild.yaml"
}


resource "google_cloudbuild_trigger" "github_code_main_push_trigger" {
  name = "code-main"
  project  = var.project_id
  github {
    owner = "m0-2s-es"
    name = "challenge1-2021-app"

    push {
      branch = "main"
    }
  }
  filename = "cloudbuild.yaml"
}

resource "google_cloudbuild_trigger" "github_code_main_pr_trigger" {
  name = "code-pr-main"
  project  = var.project_id
  github {
    owner = "m0-2s-es"
    name = "challenge1-2021-app"

    pull_request {
      branch = "main"
    }
  }
  filename = "cloudbuild-pr.yaml"
}
