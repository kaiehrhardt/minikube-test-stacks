terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "3.18.0"
    }
  }
}

variable "gitlab_token" {}
variable "minikubeip" {
  default = "192.168.49.2"
}
variable "repo_visibility_level" {
  default = "public"
}
variable "repo_names" {
  default = ["test1", "test2"]
}

provider "gitlab" {
  token    = var.gitlab_token
  base_url = "https://gitlab.${var.minikubeip}.nip.io"
  insecure = true
}

# resource "gitlab_application_settings" "this" {
#   allow_local_requests_from_web_hooks_and_services = true
#   auto_devops_enabled                              = false
# }

resource "gitlab_project" "this" {
  count            = length(var.repo_names)
  name             = var.repo_names["${count.index}"]
  description      = var.repo_names["${count.index}"]
  visibility_level = var.repo_visibility_level
}

resource "gitlab_repository_file" "this" {
  count          = length(var.repo_names)
  project        = gitlab_project.this["${count.index}"].id
  file_path      = "README.md"
  branch         = "main"
  content        = base64encode("readme text")
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "add readme text"
}
