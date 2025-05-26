resource "google_service_account" "gke_service_account" {
    account_id   = "gke-acc-shahd"
    display_name = "Service Account for GKE"
}

resource "google_container_cluster" "primary" {
  name     = "shahd-gke-cluster"
  location = "us-west2"
  network = data.google_compute_network.existing_vpc.id
  subnetwork = google_compute_subnetwork.sub_restericted.id
  initial_node_count = 1
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "105.196.77.97/32"
      display_name = "shahd-Ip"
    }
  }
   node_config {
    machine_type = "e2-micro"
    disk_type    = "pd-ssd"
    disk_size_gb = 30         

    service_account = google_service_account.gke_service_account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}