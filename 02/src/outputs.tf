output "vms" {
  description = "VM info: name, external ip, fqdn"
  value = {
    web = {
      instance_name = yandex_compute_instance.platform.name
      external_ip   = try(yandex_compute_instance.platform.network_interface[0].nat_ip_address, null)
      fqdn          = yandex_compute_instance.platform.fqdn
    }
    db = {
      instance_name = yandex_compute_instance.platform_db.name
      external_ip   = try(yandex_compute_instance.platform_db.network_interface[0].nat_ip_address, null)
      fqdn          = yandex_compute_instance.platform_db.fqdn
    }
  }
}
