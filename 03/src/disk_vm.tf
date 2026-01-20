resource "yandex_compute_disk" "storage_disks" {
  count = 3

  name = "storage-disk-${count.index + 1}"
  zone = var.default_zone
  type = var.disk_type
  size = 1
}

variable "storage_vm" {
  type = object({
    cpu           = number
    ram           = number
    boot_disk_gb  = number
  })
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.platform_id

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = var.storage_vm.cpu
    memory = var.storage_vm.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.storage_vm.boot_disk_gb
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}
