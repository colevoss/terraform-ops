resource "google_redis_instance" "cache" {
  name           = "my-redis-cache"
  tier           = "BASIC"
  memory_size_gb = 1

  authorized_network = data.google_compute_network.default.id

  display_name = "My Redis Cache"

  labels = {
    service = "my-service"
  }
}
