// Definindo tipo de resource que vai ser utilizado para o nó master e cluster
resource "google_container_cluster" "primary"{
    name = "terraform-custom"
    location= "us-central1"

    remove_default_node_pool = true
    initial_node_count = 1

    master_auth {
        username = ""
        password = ""

        client_certificate_config{
            issue_client_certificate = false
        }
    }
}

// definir node 

resource "google_container_node_pool" "primary_preemptible_nodes" {
    name = "my-node-custom"
    location = "us-central1"
    cluster = google_container_cluster.primary.name
    node_count = 1

    node_config{
        preemptible = true
        machine_type = "e2-small"
        metadata = {
            disable-legacy-endpoints = "true"
        }
        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform"
        ]
    }
}