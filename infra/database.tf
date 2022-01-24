# @see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
resource "google_sql_database_instance" "pgql-database" {
  name             = var.database_name
  database_version = "POSTGRES_13"

  settings {
    tier = var.database_tier
  }
}

# @see https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user
resource "google_sql_user" "db-user" {
  name     = var.database_user_name
  password = var.database_password

  instance = google_sql_database_instance.pgql-database.name
}
