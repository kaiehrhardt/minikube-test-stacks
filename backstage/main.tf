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

resource "tls_private_key" "cert_key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "cert" {
  private_key_pem = tls_private_key.cert_key.private_key_pem

  subject {
    common_name  = "backstage.192.168.49.2.nip.io"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "kubernetes_namespace_v1" "backstage" {
  metadata {
    name = "backstage"
  }
}

resource "kubernetes_secret_v1" "cert" {
  metadata {
    name = "cert"
    namespace = kubernetes_namespace_v1.backstage.metadata[0].name
  }

  data = {
    "tls.cert" = tls_self_signed_cert.cert.cert_pem
    "tls.key" = tls_private_key.cert_key.private_key_pem
  }
}

resource "helm_release" "backstage" {
  name             = "backstage"
  namespace        = kubernetes_namespace_v1.backstage.metadata[0].name
  repository       = "https://backstage.github.io/charts"
  chart            = "backstage"
  version          = "1.8.2"

  values = [
    "${file("values.yml")}"
  ]
}
