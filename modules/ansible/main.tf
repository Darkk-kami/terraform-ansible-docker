data "template_file" "ansible_inventory" {
  template = file("${path.module}/../../templates/inventory.tpl")
  vars = {
    private_ips = join(",", var.private_ips)
  }
}

resource "local_file" "inventory" {
  content  = data.template_file.ansible_inventory.rendered
  filename = "${path.module}/../../ansible/inventory.ini"
}


resource "null_resource" "copy_ansible" {
  provisioner "file" {
    source      = "${path.module}/../../ansible" 
    destination = "/home/ubuntu/ansible/"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/kami.pem")
      host        = var.ansible_controller.public_ip
    }
  }
  depends_on = [ var.ansible_controller ]
}


resource "null_resource" "copy_deps" {
  provisioner "file" {
    source      = "${path.module}/../../dependencies" 
    destination = "/home/ubuntu/ansible/dependencies/"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/kami.pem")
      host        = var.ansible_controller.public_ip
    }
  }
  depends_on = [ var.ansible_controller , null_resource.copy_ansible]
}

# export ANSIBLE_HOST_KEY_CHECKING=False
