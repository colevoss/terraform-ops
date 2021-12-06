# Use Google Cloud Platform provider
# @see https://registry.terraform.io/providers/hashicorp/google/latest/docs
# @see https://cloud.google.com/docs/terraform
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "google-beta" {
  # credentials = var.gcp_credentials
  project = var.gcp_project_id
  region  = var.gcp_region
}
