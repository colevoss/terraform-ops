# ======================================
# Provider Variables
# ======================================
variable "gcp_project_id" {
  type = string
}

variable "gcp_region" {
  type = string
}

# ======================================
# Service Variables
# ======================================
variable "service_image" {
  type = string
}

variable "service_name" {
  type        = string
  description = "Name of the Cloud Run service"
}

variable "service_min_instances" {
  type    = number
  default = 0
}

variable "service_max_instances" {
  type    = number
  default = 100
}

variable "service_cpu_limit" {
  type        = string
  default     = "1000m"
  description = "CPU Limit per container instance"
}

variable "service_memory_limit" {
  type        = string
  default     = "512Mi"
  description = "Memory Limit per container instance"
}

# ======================================
# Database Variables
# ======================================

variable "database_name" {
  type        = string
  description = "Name of the postgrest database"
}

variable "database_tier" {
  type        = string
  description = "Cloud SQL database Teir"
}

variable "database_user_name" {
  type        = string
  description = "Username of Cloud SQL User"
}

variable "database_password" {
  type        = string
  description = "Password for Cloud SQL User"
}

# ======================================
# Cache Variables
# ======================================

variable "cache_name" {
  type        = string
  description = "Name of the Redis cache instance"
}

variable "cache_tier" {
  type        = string
  description = "Tier of the Redis cache instance"
}

variable "cache_display_name" {
  type        = string
  description = "Display name of the Redis cache instance"
}

variable "cache_memory_size_gb" {
  type        = number
  description = "Size in GB of the cache memory"
}
