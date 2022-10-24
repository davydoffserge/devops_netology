variable "yandex_folder_id" {
  type    = string
  default = ""
}

variable "yandex_cloud_id" {
  type    = string
  default = ""
}


variable "serge_token_id" {
  type    = string
  default = ""
}


variable "zone-1a" {
  default = "ru-central1-a"
}

variable "zone-1b" {
  default = "ru-central1-b"
}

#-------------------------------------------------------

variable "domain_name" {
  default = "davydoffserge.ru"
}


variable "test_cert" {
  default = "--test-cert"


#--------------------------------------------------
#  20% vCPU and preemptible VM, save my money)))
#--------------------------------------------------

variable "core_fraction" {
  type    = number
  default = 20
}

variable "preemptible" {
  type    = bool
  default = true
}

#---------------------------------------------------------

variable "database_name" {
  default = "wordpress"
}

variable "database_user" {
  default = "wordpress"
}

variable "database_password" {
  default = "wordpress"
}


#---------------------------------------------------------

variable "database_replication_masternode" {
  default = "db01"
}

variable "database_replication_user" {
  default = "replicausr"
}

variable "database_replication_user_password" {
  default = "REplicauserpass123"
}

#----------------------------------------------------------

variable "gitlab_runner_token" {
  default = "********"
}


#--------------------------------------------------------------------------

variable "service-account-key" {
  type    = string
  default = "YC***"
}

variable "service-account-secret-key" {
  type    = string
  default = "YC*****"
}


#-------------------------------------------------------------------------------


# Токен для работы Gitlab c runner
variable "gitlab_runner" {
  default = "********"
}

# Внутренний пароль для репликации между базами MySQL
variable "replicator_psw" {
  default = "vagrantrep"
}

# Пароль для доступа к Gitlab от  `root`
variable "gitlab_psw" {
  default = "gitlab_password"
}

variable "le_staging" {
  default = "true"
}

variable "domain" {
  default = "davydoffserge.ru"
}

# Пароль для доступа к Grafana от  `admin`
variable "grafana_psw" {
  default = "admin"
}
