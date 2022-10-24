resource "local_file" "inventory" {
content         = <<-EOT
    
    # Node List

    [nginx]
    nginx ansible_host=${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}

    [db01]
    db01 ansible_host=${yandex_compute_instance.db01.network_interface.0.ip_address}

    [db02]
    db02 ansible_host=${yandex_compute_instance.db02.network_interface.0.ip_address}

    [app]
    app ansible_host=${yandex_compute_instance.app.network_interface.0.ip_address}

    [gitlab]
    gitlab ansible_host=${yandex_compute_instance.gitlab.network_interface.0.ip_address}

    [runner]
    runner ansible_host=${yandex_compute_instance.runner.network_interface.0.ip_address}

    [monitoring]
    monitoring ansible_host=${yandex_compute_instance.monitoring.network_interface.0.ip_address}

    #

    [myallhosts:children]
    nginx
    db01
    db02
    app
    gitlab
    runner
    monitoring

    [mydb:children]
    db01
    db02

    #
    
    [nginx:vars]
    domain = "${var.domain}"
    le_staging = "${var.le_staging}"

     [mydb:vars]
     replicator_psw = "${var.replicator_psw}"

    [db01:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"'
    mysql_replication_role = "master"

    [db02:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"'
    mysql_replication_role = "slave"

    [app:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"'
    domain = "${var.domain}"

    [gitlab:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"'
     gitlab_psw = "${var.gitlab_psw}"
     gitlab_runner = "${var.gitlab_runner}"
    domain = "${var.domain}"

    [runner:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"'
     gitlab_runner = "${var.gitlab_runner}"
    domain = "${var.domain}"

    [monitoring:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"'
     grafana_psw = ${var.grafana_psw}

    [myallhosts:vars]
    domain = "${var.domain}"
    ip_nginx = ${yandex_compute_instance.nginx.network_interface.0.ip_address}
    ip_db01 = ${yandex_compute_instance.db01.network_interface.0.ip_address}
    ip_db02 = ${yandex_compute_instance.db02.network_interface.0.ip_address}
    ip_app = ${yandex_compute_instance.app.network_interface.0.ip_address}
    ip_gitlab = ${yandex_compute_instance.gitlab.network_interface.0.ip_address}
    ip_runner = ${yandex_compute_instance.runner.network_interface.0.ip_address}
    ip_monitoring = ${yandex_compute_instance.monitoring.network_interface.0.ip_address}

    EOT
  filename        = "../ansible/inventory.yml"
  file_permission = "0777"

  depends_on = [
    yandex_compute_instance.nginx,
    yandex_compute_instance.db01,
    yandex_compute_instance.db02,
    yandex_compute_instance.app,
    yandex_compute_instance.gitlab,
    yandex_compute_instance.runner,
    yandex_compute_instance.monitoring
  ]
}
