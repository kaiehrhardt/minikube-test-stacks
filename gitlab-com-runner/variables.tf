variable "runner_secret_name" {
  type = string
  default = "runnner-token"
}

variable "runner_secret" {
  type = string
  sensitive = true
}
