resource "google_redis_instance" "cache" {
  name           = var.cache_name
  tier           = var.cache_tier
  memory_size_gb = var.cache_memory_size_gb

  authorized_network = data.google_compute_network.default.id

  display_name = var.cache_display_name

  labels = {
    service = var.service_name
  }
}
