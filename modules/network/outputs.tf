output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "security_group_id" {
  value = aws_security_group.app_sg.id
}

output "subnet_ids" {
  value = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "ansible_sg_id" {
  value = aws_security_group.ansible_sg.id
}