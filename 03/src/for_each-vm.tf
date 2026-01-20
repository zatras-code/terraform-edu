variable "platform_id" {
  type = string
}

variable "disk_type" {
  type = string
}

variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
}

locals {
  db_vms = { for vm in var.each_vm : vm.vm_name => vm }
}

resource "yandex_compute_instance" "db" {
  for_each = local.db_vms

  name        = each.value.vm_name
  platform_id = var.platform_id

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = each.value.disk_volume
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}
