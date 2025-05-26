data "google_compute_network" "existing_vpc" {
  name = "shaimaa-custom"
}

resource "google_compute_subnetwork" "sub_management" {
  name          = "shahd-management-subnet"
  ip_cidr_range = "10.0.5.0/24"
  region        = "us-west1"
  network       = data.google_compute_network.existing_vpc.id
  private_ip_google_access = true
}
resource "google_compute_subnetwork" "sub_restericted" {
  name          = "shahd-restricted-subnet"
  ip_cidr_range = "10.0.6.0/24"
  region        = "us-west2"
  network       = data.google_compute_network.existing_vpc.id
  private_ip_google_access = false
}
