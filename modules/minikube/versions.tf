terraform {
  required_version = ">= 1.0"

  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = ">= 0.3.4"
    }
  }
}
