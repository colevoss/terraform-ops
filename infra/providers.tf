provider "google" {
  # credentials = var.gcp_credentials
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "google-beta" {
  # credentials = var.gcp_credentials
  project = var.gcp_project_id
  region  = var.gcp_region
}
