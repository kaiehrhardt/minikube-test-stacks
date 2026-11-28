terraform {
  required_version = "1.17.2"

  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.8.0"
    }
  }
}
