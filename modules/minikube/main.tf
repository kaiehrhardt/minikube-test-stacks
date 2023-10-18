provider "minikube" {
  kubernetes_version = var.kubernetes_version
}

resource "minikube_cluster" "docker" {
  driver       = var.driver
  cluster_name = var.clustername
  cpus         = var.cpus
  memory       = var.memory
  addons       = var.addons
  cni          = "bridge"
}

output "client_certificate" {
  value     = minikube_cluster.docker.client_certificate
  sensitive = true
}

output "client_key" {
  value     = minikube_cluster.docker.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = minikube_cluster.docker.cluster_ca_certificate
  sensitive = true
}

output "host" {
  value     = minikube_cluster.docker.host
  sensitive = true
}

output "ip" {
  value = split(":", trimprefix(minikube_cluster.docker.host, "https://"))[0]
}
