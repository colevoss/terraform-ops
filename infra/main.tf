terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.2.1"
    }
  }

  # Used for backing up terraform state in a Google Cloud Storage bucket
  # @see https://www.terraform.io/docs/language/settings/backends/gcs
  backend "gcs" {
    # bucket = "playground-infra"
    prefix = "terraform/state"
  }
}
