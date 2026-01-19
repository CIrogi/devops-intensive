
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

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = ""
}