variable "gcp_project_id" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "my_service_image" {
  type = string
}

variable "service_min_instances" {
  type    = number
  default = 0
}