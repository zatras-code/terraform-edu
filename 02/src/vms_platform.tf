variable "vm_db_name" {
  type    = string
  default = "netology-develop-platform-db"
}

variable "vm_db_platform_id" {
  type    = string
  default = "standard-v3"
}

variable "vm_db_zone" {
  type    = string
  default = "ru-central1-b"
}

variable "db_cidr" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

# variable "vm_db_cores" { type = number default = 2 }
# variable "vm_db_memory" { type = number default = 2 }
# variable "vm_db_core_fraction" { type = number default = 20 }
# variable "vm_db_preemptible" { type = bool default = true }
# variable "vm_db_nat" { type = bool default = true }
# variable "vm_db_serial_port_enable" { type = number default = 1 }
# variable "vm_db_ssh_user" { type = string default = "ubuntu" }
