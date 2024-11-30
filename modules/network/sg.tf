# Application Security Group
resource "aws_security_group" "app_sg" {
  name        = "app_sg"
  description = "Allow TLS traffic inbound and all outbound"
  vpc_id      = aws_vpc.vpc.id
  tags        = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_ansible" {
  security_group_id          = aws_security_group.app_sg.id
  referenced_security_group_id = aws_security_group.ansible_sg.id
  from_port                  = 22
  to_port                    = 22
  ip_protocol                = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  for_each          = { for idx, port in var.inbound_ports : idx => port }
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = aws_vpc.vpc.cidr_block
  from_port         = each.value
  to_port           = each.value
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "app_allow_all_outbound" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}


# Ansible Security Group
resource "aws_security_group" "ansible_sg" {
  name        = "ansible_sg"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.vpc.id
  tags        = var.tags
}

# Allow SSH Inbound to Ansible Controller
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ansible_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "ansible_to_app" {
  security_group_id          = aws_security_group.ansible_sg.id
  referenced_security_group_id = aws_security_group.app_sg.id
  from_port                  = 22
  to_port                    = 22
  ip_protocol                = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ansible_to_internet" {
  security_group_id = aws_security_group.ansible_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"       
}