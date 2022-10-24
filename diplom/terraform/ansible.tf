resource "null_resource" "play" {

  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/play.yml"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "site" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/site.yml"
  }

  depends_on = [
    null_resource.play
  ]
}

resource "null_resource" "mysql" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/mysql.yml"
  }

 depends_on = [
    null_resource.site
  ]
}

resource "null_resource" "app" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/app.yml"
  }

 depends_on = [
    null_resource.mysql
  ]
}

resource "null_resource" "gitlab" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/gitlab.yml"
  }

 depends_on = [
    null_resource.app
  ]
}

resource "null_resource" "monitoring" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../ansible/inventory.yml ../ansible/monitoring.yml"
  }

 depends_on = [
    null_resource.gitlab
  ]
}
