resource "helm_release" "opensearch" {
  name             = "opensearch"
  namespace        = "opensearch"
  create_namespace = true
  repository       = "https://opensearch-project.github.io/helm-charts/"
  chart            = "opensearch"
  version          = "2.21.0"
  timeout          = "1800"

  values = [
    templatefile("./values-os.tftpl.yaml", { ip = module.mk.ip })
  ]
}

resource "helm_release" "opensearch_dashboard" {
  name             = "opensearch-dashboard"
  namespace        = "opensearch"
  create_namespace = false
  repository       = "https://opensearch-project.github.io/helm-charts/"
  chart            = "opensearch-dashboards"
  version          = "2.19.0"
  timeout          = "1800"

  values = [
    templatefile("./values-os-dash.tftpl.yaml", { ip = module.mk.ip })
  ]

  depends_on = [ helm_release.opensearch ]
}
