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
  version          = "7.5.0"
  timeout          = "720"

  values = [<<EOT
    global:
      ingress:
        configureCertmanager: false
        class: "nginx"
      hosts:
        domain: ${module.mk.ip}.nip.io
        externalIP: "${module.mk.ip}"
      kas:
        enabled: false
    certmanager:
      install: false
    nginx-ingress:
      enabled: false
    registry:
      enabled: false
    prometheus:
      install: false
    gitlab:
      webservice:
        minReplicas: 1
        maxReplicas: 1
      sidekiq:
        minReplicas: 1
        maxReplicas: 1
      gitlab-shell:
        enabled: false
    gitlab-runner:
      certsSecretName: gitlab-wildcard-tls-chain
  EOT
  ]
}
