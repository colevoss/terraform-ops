resource "google_cloud_run_service" "my_service" {
  name     = "my-service"
  location = var.gcp_region

  template {
    spec {
      container_concurrency = 80
      containers {
        image = var.my_service_image
        env {
          name  = "REDISHOST"
          value = google_redis_instance.cache.host
        }

        env {
          name  = "REDISPORT"
          value = google_redis_instance.cache.port
        }

        env {
          name = "DATABASE_URL"
          value = format(
            "postgres://%s:%s@%s/%s?host=/cloudsql/%s",
            google_sql_user.db-user.name,                                 # username
            google_sql_user.db-user.password,                             # password
            google_sql_database_instance.pgql-database.public_ip_address, # Public IP Address
            google_sql_database_instance.pgql-database.name,              # Database name
            google_sql_database_instance.pgql-database.connection_name    # Connection name
          )
        }

        resources {
          limits = {
            "cpu"    = "1000m"
            "memory" = "512Mi"
          }
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"        = "100"
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.vpcconnector.name
        "run.googleapis.com/cloudsql-instances"   = google_sql_database_instance.pgql-database.connection_name
      }
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
