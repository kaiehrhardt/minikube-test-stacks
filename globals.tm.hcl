globals "terraform" {
  version = ">= 1.0"
}

globals "terraform" "provider" "minikube" {
  source = "scott-the-programmer/minikube"
  version = ">= 0.3.4"
}

globals "terraform" "provider" "helm" {
  source = "hashicorp/helm"
  version = ">= 2.11.0"
}

globals "terraform" "provider" "kubernetes" {
  source = "hashicorp/kubernetes"
  version = ">= 2.32.0"
}