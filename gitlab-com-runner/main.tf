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
  version          = "0.85.0"

  values = [
    "${file("values.yml")}"
  ]
  set {
    name  = "runners.secret"
    value = kubernetes_secret_v1.gitlab_runner.metadata[0].name
  }
}
