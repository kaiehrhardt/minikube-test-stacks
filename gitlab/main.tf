resource "helm_release" "gitlab" {
  name             = "gitlab"
  namespace        = "gitlab"
  create_namespace = true
  repository       = "https://charts.gitlab.io/"
  chart            = "gitlab"
  version          = "9.8.4"
  timeout          = "1800"

  values = [
    templatefile("./values.tftpl.yaml", { ip = module.mk.ip })
  ]
}
