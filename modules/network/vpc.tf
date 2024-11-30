resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = var.dns_hostnames

  tags = var.tags
}

# Find avaialble zones based on the provided region
data "aws_availability_zones" "available_azs" {
  state = "available"
}

# Calculate the effective number of AZs (default to max available if input exceeds the available azs)
locals {
  effective_azs = min(var.desired_azs, length(data.aws_availability_zones.available_azs.names))

  az_list = slice(data.aws_availability_zones.available_azs.names, 0, local.effective_azs)
}


resource "aws_subnet" "public_subnets" {
  count = var.public_subnets_no

  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = local.az_list[count.index % length(local.az_list)]

  map_public_ip_on_launch = var.map_public_ip

  tags = var.tags

}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = var.tags
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = var.tags
}


resource "aws_route_table_association" "public_route_table_association" {
  for_each       = { for idx, subnet in aws_subnet.public_subnets : idx => subnet }
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = each.value.id
  depends_on     = [aws_subnet.public_subnets]
}