provider "kubernetes" {
  host = module.mk.host

  client_certificate     = module.mk.client_certificate
  client_key             = module.mk.client_key
  cluster_ca_certificate = module.mk.cluster_ca_certificate
}

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

resource "kubernetes_namespace_v1" "gitlab_runner" {
  metadata {
    name = "gitlab-runner"
  }
}

resource "kubernetes_secret_v1" "gitlab_runner" {
  metadata {
    name = var.runner_secret_name
    namespace = kubernetes_namespace_v1.gitlab_runner.metadata[0].name
  }

  data = {
    runner-registration-token = var.runner_secret
    runner-token = ""
  }
}

resource "helm_release" "gitlab_runner" {
  name             = "gitlab"
  namespace        = kubernetes_namespace_v1.gitlab_runner.metadata[0].name
  repository       = "https://charts.gitlab.io/"
  chart            = "gitlab-runner"
  version          = "0.63.0"

  values = [
    "${file("values.yml")}"
  ]
  set {
    name  = "runners.secret"
    value = kubernetes_secret_v1.gitlab_runner.metadata[0].name
  }
}
