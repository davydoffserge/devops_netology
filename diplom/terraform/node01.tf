#---------------------------MY_SQL1------------------------------------
#-----------------------------------------------------------------------

resource "yandex_compute_instance" "db01" {
  name = "db01"
  zone = var.zone-1b
  hostname = "db01.${var.domain_name}"
  resources {
    core_fraction = var.core_fraction
    cores = 4
    memory = 8
  }

#--------------------------------save money------------------------------
  scheduling_policy {
    preemptible = var.preemptible
  }

#var.core_fraction (20%) vCPU and preemptible VM, save my money)))
#------------------------------------------------------------------------

  boot_disk {
    initialize_params {
     image_id = "fd8kdq6d0p8sij7h5qe3" 
      name     = "root-db01"
      size = "10"
  }
}
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
  #  nat       = true
    ip_address = "192.168.101.12"

#-------------------------------------------------------------------------
#------------------------------------------------------------------    
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
#
  depends_on = [
    yandex_vpc_network.default
  ]
}
