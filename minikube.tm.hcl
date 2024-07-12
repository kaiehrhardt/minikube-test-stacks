generate_hcl "_generated_main.tf" {
  content {
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

      driver = global.driver
    }

    # output used for testing
    output "ip" {
      value = module.mk.ip
    }
  }
}
