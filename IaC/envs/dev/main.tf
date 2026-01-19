module "bastion" {
  source = "./modules/bastion"

  instance_type = var.instance_type
  ami_id        = data.aws_ami.ubuntu.id
  key_name      = "my-key-pair"
  subnet_id     = "subnet-0123456789abcdef0"
  create_vm     = true  
}


module "db_server" {
  source = "./modules/db"

  instance_type = var.instance_type
  db_size    = "20"
  ami_id        = data.aws_ami.ubuntu.id
  key_name      = "my-key-pair"
  subnet_id     = "subnet-0123456789abcdef0"
  create_vm     = true  
}



module "firewall" {
  source = "./modules/security"

  instance_type = var.instance_type
  ami_id        = data.aws_ami.ubuntu.id
  key_name      = "my-key-pair"
  subnet_id     = "subnet-0123456789abcdef0"
  create_vm     = true  
}