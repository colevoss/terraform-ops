resource "google_sql_database_instance" "pgql-database" {
  name             = "my-postgres-db"
  database_version = "POSTGRES_13"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "db-user" {
  name     = "me"
  password = "mydbpassword"
  instance = google_sql_database_instance.pgql-database.name
}