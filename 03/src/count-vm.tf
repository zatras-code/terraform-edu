variable "web_vm" {
  type = object({
    cpu         = number
    ram         = number
    disk_volume = number
  })
}

resource "yandex_compute_instance" "web" {
  count = 2

  name        = "web-${count.index + 1}"
  platform_id = var.platform_id

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores  = var.web_vm.cpu
    memory = var.web_vm.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.web_vm.disk_volume
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id

    security_group_ids = [
      data.yandex_vpc_security_group.selected.id
    ]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  depends_on = [yandex_compute_instance.db]
}
