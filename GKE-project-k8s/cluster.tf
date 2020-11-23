resource "google_container_cluster" "primary" {
  name               =  var.project_name
  location           = var.region
  initial_node_count = var.node_count

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    machine_type = "e2-small"

    metadata = {
      disable-legacy-endpoints = "true"
    }
     labels = {
      app = var.project_name
    }

    tags = ["app", var.project_name]

  }

  timeouts {
    create = "30m"
    update = "40m"
  }
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${google_container_cluster.primary.location} --project kubernets-estudo"
  }
  provisioner "local-exec" {
    command = "sh script.sh"
  }

}