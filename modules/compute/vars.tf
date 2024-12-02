variable "distro_version" {
  description = "The version of the Linux distribution"
  type        = string
  default     = "24.04" 
}

variable "security_group_id" {
}

variable "subnet_id" {
}

variable "instance_count" {
  description = "number of instances"
  type = number
  default = 1
}

variable "ansible_controller-sg" {
  
}

variable "instance_profile" {
  default = ""
}

variable "instance_type" {
}

variable "private_key" {
}

variable "tls_key" {
}