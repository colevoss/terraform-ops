resource "google_cloud_run_service" "my_service" {
  name     = "my-service"
  location = var.gcp_region

  template {
    spec {
      containers {
        image = var.my_service_image
      }
    }

    metadata {
      labels = {
        service = "my-service"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.my_service.location
  project  = google_cloud_run_service.my_service.project
  service  = google_cloud_run_service.my_service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
