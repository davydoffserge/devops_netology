#----------------------------------------------------
# NETWORK
#-----------------------------------------------------
resource "yandex_vpc_network" "default" {
  name = "default"
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "default-ru-central1-a"
  zone           = var.zone-1a
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.100.0/24"]


  depends_on = [
    yandex_vpc_network.default
  ]
}


resource "yandex_vpc_route_table" "route" {
  network_id = "${yandex_vpc_network.default.id}"

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.100.11"
  }
}

#-----------------------------------------------------------

resource "yandex_vpc_subnet" "subnet-b" {
  name           = "subnet-b"
  zone           = var.zone-1b
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.101.0/24"]

  depends_on = [
    yandex_vpc_network.default
  ]
}

