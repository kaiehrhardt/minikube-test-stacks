terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "17.1.0"
    }
  }
}

variable "gitlab_token" {}
variable "minikubeip" {
  default = "192.168.49.2"
}
variable "hook_pass" {
  default = "1234567"
}
variable "import_url" {
  default = "https://github.com/kaiehrhardt/cron-viewer"
}
variable "repo_visibility_level" {
  default = "public"
}
variable "repo_names" {
  default = ["tekton-el-test1", "tekton-el-test2"]
}

provider "gitlab" {
  token    = var.gitlab_token
  base_url = "https://gitlab.${var.minikubeip}.nip.io"
  insecure = true
}

resource "gitlab_application_settings" "this" {
  allow_local_requests_from_web_hooks_and_services = true
  auto_devops_enabled                              = false
}

resource "gitlab_project" "this" {
  count            = length(var.repo_names)
  name             = var.repo_names["${count.index}"]
  description      = var.repo_names["${count.index}"]
  import_url       = var.import_url
  visibility_level = var.repo_visibility_level
}

resource "gitlab_project_hook" "this" {
  count                   = length(var.repo_names)
  project                 = gitlab_project.this["${count.index}"].id
  url                     = "http://trigger.${var.minikubeip}.nip.io"
  token                   = var.hook_pass
  push_events             = true
  tag_push_events         = true
  enable_ssl_verification = false

  depends_on = [
    gitlab_application_settings.this
  ]
}

# trigger webhook
resource "gitlab_repository_file" "this" {
  count          = length(var.repo_names)
  project        = gitlab_project.this["${count.index}"].id
  file_path      = "WEBHOOK.md"
  branch         = "main"
  content        = base64encode("webhook trigger test")
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "webhook trigger test"

  depends_on = [
    gitlab_project_hook.this
  ]
}
