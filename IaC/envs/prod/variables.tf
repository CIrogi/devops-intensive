

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "instance_name" {
  description = "EC2 instance name tag"
  type        = string
  default     = "HelloWorld"
}

variable "create_vm" {
  description = "Whether to create the VM instance"
  type        = bool
  default     = true
}

variable "vm_firewall_ports" {
  description = "TCP ports to open to the VM (used for security group ingress rules)"
  type        = list(number)
  default     = [
    80, 
    # 443, 
    22, 
    5432, 
    3306
    ]
}

variable "vm_firewall_ports_map" {
  description = "Firewall rules to open to the VM (map key is rule name; value includes port and description)"
  type = map(object({
    port        = number
    description = string
  }))
  default = {
    http = {
      port        = 80
      description = "Allow HTTP"
    }
    # https = {
    #   port        = 443
    #   description = "Allow HTTPS"
    # }
    ssh = {
      port        = 22
      description = "Allow SSH"
    }
    postgres = {
      port        = 5432
      description = "Allow PostgreSQL"
    }
  }
}
