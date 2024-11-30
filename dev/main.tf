module "network" {
  source = "../modules/network"
  dns_hostnames = "true"
  public_subnets_no = 3
  desired_azs = 100
  map_public_ip = true
  inbound_ports = [ 22, 80, 443 ]
  tags = {
    env = "dev"
  }
}

module "compute" {
  source = "../modules/compute"
  distro_version = "22.04"
  security_group_id = module.network.security_group_id
  subnet_id = module.network.subnet_ids
  ansible_controller-sg = module.network.ansible_sg_id
}


module "ansible" {
  source = "../modules/ansible"
  private_ips = module.compute.app_instance_private_ips
  ansible_controller = module.compute.ansible_controller
  depends_on = [ module.domain, module.compute ]
}

module "domain" {
  source = "../modules/domain"
  domain = "example.com"
}
