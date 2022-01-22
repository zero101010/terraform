resource "google_container_cluster" "primary" {

  name               =  var.project_name
  location           = var.region
  initial_node_count = var.node_count

  master_auth {
    username = ""
    password = ""

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
  network_policy {
    enabled = true
  }

  timeouts {
    create = "50m"
    update = "50m"
  }
  provisioner "local-exec" {
    command = <<EOT
      gcloud container clusters get-credentials $PROJECT_NAME --zone us-central1-a --project $PROJECT_ID
      echo "------------install knative------------"
      kubectl apply -f https://github.com/knative/serving/releases/download/v0.22.0/serving-crds.yaml
      kubectl apply -f https://github.com/knative/serving/releases/download/v0.22.0/serving-core.yaml
      echo "------------install istio inside knative------------"
      kubectl apply -f https://github.com/knative/net-istio/releases/download/v0.22.0/istio.yaml
      kubectl apply -f https://github.com/knative/net-istio/releases/download/v0.22.0/net-istio.yaml
      kubectl --namespace istio-system get service istio-ingressgateway
      echo "------------Update dns config------------"
      kubectl patch configmap/config-domain --namespace knative-serving --type merge --patch '{"data":{"devopstests.com":""}}'
  EOT
    environment = {
      PROJECT_NAME = var.project_name
      PROJECT_ID = var.project_id
    }
  }
}

