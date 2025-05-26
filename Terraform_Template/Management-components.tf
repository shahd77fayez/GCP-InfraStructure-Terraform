resource "google_compute_router" "router" {
  name    = "shahd-manage-nat-router"
  region  = google_compute_subnetwork.sub_management.region
  network = data.google_compute_network.existing_vpc.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "shahd-manage-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
resource "google_compute_instance" "vm_management" {
  name         = "shahd-vm-management"
  machine_type = "e2-medium"
  zone         = "us-west1-a"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }
   service_account {
    email  = google_service_account.gke_service_account.email
    scopes = ["cloud-platform"]
  }

  network_interface {
    subnetwork = google_compute_subnetwork.sub_management.id
  }
}
