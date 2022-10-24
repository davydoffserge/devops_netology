#-----------------------------PROXY_REVERSE-------------------------------
#--------------------------------------------------------------------------

resource "yandex_compute_instance" "nginx" {
  name = "nginx"
  zone = var.zone-1a
  hostname = var.domain_name
    resources {
    cores  = 2
    memory = 2
#    core_fraction = var.core_fraction
  }

#----------------------------save money------------------------------------
 #  scheduling_policy {
  #  preemptible = var.preemptible
 # }
#var.core_fraction (20%) vCPU and preemptible VM, save my money)))
#-------------------------------------------------------------------------------
  boot_disk {
    initialize_params {
     image_id = "fd8kdq6d0p8sij7h5qe3"
      name     = "root-nginx"
      size = "10"
    }
  }

#---------------------------------------------------------------------
#------------------------------------------------------------------------------

  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-a.id
      nat = true
      ip_address = "192.168.100.11"

  }
   metadata = {
     ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
   }
#


#---------------------------------------------------------------------------

  depends_on = [
    yandex_vpc_network.default
  ]

}

