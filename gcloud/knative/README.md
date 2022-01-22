# K8s Cluster create (+knative)

``git clone https://git.mcontigo.com/devops/k8s``

``cd k8s/knative``
- Before run terraform is necessary add the credentials of gcloud, and change the name to `service_account.json`, after is only necessary update the name of project in `provider.tf`and change the `variables.tf` if you can

``terraform init``

``terraform apply``
