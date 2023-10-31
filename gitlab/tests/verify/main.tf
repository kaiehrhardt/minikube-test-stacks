terraform {
  required_version = ">= 1.0"

  required_providers {
    terracurl = {
      source  = "devops-rob/terracurl"
      version = "1.1.0"
    }
  }
}

provider "terracurl" {}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

variable "mk_ip" {
  type = string
}

data "kubernetes_secret" "gitlab_ca" {
  metadata {
    name = "gitlab-wildcard-tls-ca"
    namespace = "gitlab"
  }
}

data "kubernetes_secret" "gitlab_cert" {
  metadata {
    name = "gitlab-wildcard-tls"
    namespace = "gitlab"
  }
}

resource "local_file" "ca" {
  content  = data.kubernetes_secret.gitlab_ca.data.cfssl_ca
  filename = "${path.module}/ca.pem"
}

resource "local_file" "cert" {
  content  = data.kubernetes_secret.gitlab_cert.data["tls.crt"]
  filename = "${path.module}/cert.pem"
}

resource "local_file" "key" {
  content  = data.kubernetes_secret.gitlab_cert.data["tls.key"]
  filename = "${path.module}/cert.key"
}

data "terracurl_request" "test" {
  name   = "check"
  url    = "https://gitlab.${var.mk_ip}.nip.io"
  method = "GET"

  response_codes = [200]

  ca_cert_file = local_file.ca.filename
  cert_file = local_file.cert.filename
  key_file = local_file.key.filename

  max_retry      = 3
  retry_interval = 10
}
