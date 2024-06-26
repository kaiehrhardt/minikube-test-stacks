provider "minikube" {
  kubernetes_version = var.kubernetes_version
}

resource "minikube_cluster" "cluster" {
  driver       = var.driver
  cluster_name = var.clustername
  cpus         = var.cpus
  memory       = var.memory
  addons       = var.addons
  cni          = "bridge"
}

output "client_certificate" {
  value     = minikube_cluster.cluster.client_certificate
  sensitive = true
}

output "client_key" {
  value     = minikube_cluster.cluster.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = minikube_cluster.cluster.cluster_ca_certificate
  sensitive = true
}

output "host" {
  value     = minikube_cluster.cluster.host
  sensitive = true
}

output "ip" {
  value = split(":", trimprefix(minikube_cluster.cluster.host, "https://"))[0]
}
