// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

provider "helm" {
  kubernetes {
    client_certificate     = module.mk.client_certificate
    client_key             = module.mk.client_key
    cluster_ca_certificate = module.mk.cluster_ca_certificate
    host                   = module.mk.host
  }
}
module "mk" {
  source = "../modules/minikube"
}
output "ip" {
  value = module.mk.ip
}
