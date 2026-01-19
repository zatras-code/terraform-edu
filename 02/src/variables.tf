### cloud vars

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "compute_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_web_name" {
  type    = string
  default = "netology-develop-platform-web"
}

variable "vm_web_platform_id" {
  type    = string
  default = "standard-v3"
}

### ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}

variable "metadata" {
  description = "Common metadata for all VMs (ssh-keys will be merged per VM)"
  type        = map(string)
  default = {
    serial-port-enable = "1"
  }
}

variable "vms_resources" {
  description = "Resources and common flags for VMs"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    preemptible   = bool
    nat           = bool
    ssh_user      = string
  }))

  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 20
      preemptible   = true
      nat           = true
      ssh_user      = "ubuntu"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      preemptible   = true
      nat           = true
      ssh_user      = "ubuntu"
    }
  }
}

# variable "vm_web_cores" { type = number default = 2 }
# variable "vm_web_memory" { type = number default = 1 }
# variable "vm_web_core_fraction" { type = number default = 20 }
# variable "vm_web_preemptible" { type = bool default = true }
# variable "vm_web_nat" { type = bool default = true }
# variable "vm_web_serial_port_enable" { type = number default = 1 }
# variable "vm_web_ssh_user" { type = string default = "ubuntu" }
