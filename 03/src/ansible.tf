locals {
  web_hosts = [
    for vm in yandex_compute_instance.web : {
      name = vm.name
      host = coalesce(try(vm.network_interface[0].nat_ip_address, null), vm.network_interface[0].ip_address)
      fqdn = try(vm.fqdn, "")
    }
  ]

  db_hosts = [
    for _, vm in yandex_compute_instance.db : {
      name = vm.name
      host = coalesce(try(vm.network_interface[0].nat_ip_address, null), vm.network_interface[0].ip_address)
      fqdn = try(vm.fqdn, "")
    }
  ]

  storage_hosts = [
    {
      name = yandex_compute_instance.storage.name
      host = coalesce(try(yandex_compute_instance.storage.network_interface[0].nat_ip_address, null), yandex_compute_instance.storage.network_interface[0].ip_address)
      fqdn = try(yandex_compute_instance.storage.fqdn, "")
    }
  ]
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"
  content = templatefile("${path.module}/inventory.tftpl", {
    webservers = local.web_hosts
    databases  = local.db_hosts
    storage    = local.storage_hosts
  })
}
