data "google_compute_network" "default" {
  name = "default"
}

resource "google_vpc_access_connector" "vpcconnector" {
  provider      = google-beta
  name          = "vpcconnector"
  ip_cidr_range = "10.8.0.0/28"
  network       = data.google_compute_network.default.name
}
