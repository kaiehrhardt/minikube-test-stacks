terraform {
  required_version = "1.16.4"

  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.8.0"
    }
  }
}
