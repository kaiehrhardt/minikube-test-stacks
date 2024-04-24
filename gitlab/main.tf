provider "helm" {
  kubernetes {
    host = module.mk.host

    client_certificate     = module.mk.client_certificate
    client_key             = module.mk.client_key
    cluster_ca_certificate = module.mk.cluster_ca_certificate
  }
}

module "mk" {
  source = "../modules/minikube"
}

resource "helm_release" "gitlab" {
  name             = "gitlab"
  namespace        = "gitlab"
  create_namespace = true
  repository       = "https://charts.gitlab.io/"
  chart            = "gitlab"
  version          = "7.11.1"
  timeout          = "1800"

  values = [
    templatefile("./values.tftpl.yaml", { ip = module.mk.ip })
  ]
}

# output used for testing
output "ip" {
  value = module.mk.ip
}
