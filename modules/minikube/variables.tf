variable "kubernetes_version" {
  default = "v1.27.7"
  type    = string
}

variable "cpus" {
  default = 4
  type    = number
}

variable "memory" {
  default = "8192mb"
  type    = string
}

variable "clustername" {
  default = "docker"
  type    = string
}

variable "addons" {
  default = ["ingress", "default-storageclass", "storage-provisioner"]
  type    = list(string)
}

variable "driver" {
  default = "docker"
  type    = string
}
