provider "google" {
  version = "3.5.0"
  credentials = file("service_account.json")
  project = var.project_id
  zone = "us-central1-c"
}
