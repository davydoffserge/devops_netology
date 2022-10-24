terraform {
  required_version = "= 1.3.1"

  required_providers {
    yandex = {
    source  = "yandex-cloud/yandex"
    version = "= 0.78.1"
    }
  }
#----------------------------------------------------------------------------

#backend "s3" {
#    endpoint = "storage.yandexcloud.net"
#    bucket   = "netology-davydoffserge"
#    region   = "ru-central1"
#    key      = "[terraform.workspace]/terraform-stage.tfstate"
#
#    skip_region_validation      = true
#    skip_credentials_validation = true
#  }
}

#--------------------------------------------------------------------------------------------



provider "yandex" {
  token     = var.serge_token_id
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone      = "ru-central1-a"
}

