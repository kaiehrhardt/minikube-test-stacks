resource "kubernetes_namespace_v1" "kubeai" {
  metadata {
    name = "kubeai"
  }
}

resource "helm_release" "kubeai" {
  name             = "kubeai"
  namespace        = kubernetes_namespace_v1.kubeai.metadata[0].name
  repository       = "https://www.kubeai.org"
  chart            = "./charts/kubeai"

  values = [
    templatefile("./values.tftpl.yaml", { ip = module.mk.ip })
  ]
}

resource "helm_release" "kubeai-models" {
  name             = "models"
  namespace        = kubernetes_namespace_v1.kubeai.metadata[0].name
  repository       = "https://www.kubeai.org"
  chart            = "models"

  values = [
    "${file("values-models.yml")}"
  ]
}
