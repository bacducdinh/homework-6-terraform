resource "google_compute_network" "duc_bac_cloudrun_network" {
  name = "duc-bac-cloudrun-network"
}

resource "google_compute_subnetwork" "duc_bac_subnetwork" {
  name          = "duc-bac-subnetwork"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.duc_bac_cloudrun_network.self_link
  region        = var.region
}

resource "google_compute_router" "duc_bac_router" {
  name    = "duc-bac-router"
  network = google_compute_network.duc_bac_cloudrun_network.self_link
  region  = var.region
}

resource "google_compute_address" "duc_bac_nat_ip" {
  name   = "duc-bac-nat-ip"
  region = var.region
}

resource "google_compute_router_nat" "duc_bac_nat_gateway" {
  name                               = "duc-bac-nat-gateway"
  router                             = google_compute_router.duc_bac_router.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.duc_bac_nat_ip.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
resource "google_vpc_access_connector" "duc_bac_serverless_vpc_connector" {
  name          = "duc-bac-serverless-vpc-connector"
  region        = var.region
  network       = google_compute_network.duc_bac_cloudrun_network.name
  ip_cidr_range = "10.15.0.0/28"
}
