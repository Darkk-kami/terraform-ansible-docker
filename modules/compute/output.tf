output "app_instance_ips" {
  value = [for instance in aws_instance.app_instance : instance.public_ip]
}

output "app_instance_private_ips" {
  value = flatten([for instance in aws_instance.app_instance : instance.private_ip])
}


output "ansible_controller" {
  value = aws_instance.ansible_controller
}