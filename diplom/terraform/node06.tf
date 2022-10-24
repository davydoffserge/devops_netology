#----------------GRAFANA_PROMETHEUS_ALERT_MANAGER---------------------------
#-----------------------------------------------------------------------------

resource "yandex_compute_instance" "monitoring" {
  name = "monitoring"
  zone = var.zone-1b
  hostname = "monitoring.${var.domain_name}"
  resources {
    core_fraction = var.core_fraction
    cores = 4
    memory = 4
  }

#----------------------------save money-----------------------------

  scheduling_policy {
    preemptible = var.preemptible
  }
#var.core_fraction (20%) vCPU and preemptible VM, save my money)))
#----------------------------------------------------------------------
  boot_disk {
    initialize_params {
     image_id = "fd8kdq6d0p8sij7h5qe3"
      name     = "root-monitoring"
      size = "10"
  }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
 #   nat       = false
    ip_address = "192.168.101.17"

  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

#-------------------------------------------------------------------------
  depends_on = [
    yandex_vpc_network.default
  ]

}

