#-------WORDPRESS----------------------------------------------------
#---------------------------------------------------------------

resource "yandex_compute_instance" "app" {
  name     = "app"
  zone     = var.zone-1b
  hostname = "app.${var.domain_name}"
  resources {
    core_fraction = var.core_fraction
    cores = 4
    memory = 4
  }

#---------------------save money-------------------

  scheduling_policy {
    preemptible = var.preemptible
  }
#var.core_fraction (20%) vCPU and preemptible VM, save my money)))
#-------------------------------------------------------

  boot_disk {
    initialize_params {
    image_id = "fd8kdq6d0p8sij7h5qe3"
      name     = "root-app"
      size = "10"
  }
}
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
#    nat = true
    ip_address = "192.168.101.14"

#------------------------------------------------------------------
#-------------------------------------------------------------------

  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

#-------------------------------------------------------------------
  depends_on = [
    yandex_vpc_network.default
  ]

#  depends_on = [
#    yandex_vpc_subnet.default-ru-central1-b
#  ]

}
