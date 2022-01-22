// Provisiona credenciais e qual ferramenta são utilizadas(AWS,GCLOUD,Azure)
provider "google" {
  version = "3.5.0"
  credentials = file("../key_service_count.json")
  project = "kubernets-estudo"
  zone = "us-central1-c"
}

