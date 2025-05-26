resource "google_artifact_registry_repository" "shahd_apprepo" {
  location      = "us-central1"
  repository_id = "shahd-repo"
  format        = "DOCKER"
  description   = "Private Docker repo for GKE dep"
}
