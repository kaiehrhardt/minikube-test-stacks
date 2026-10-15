terraform {
  required_version = "1.16.6"

  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.8.0"
    }
  }
}
