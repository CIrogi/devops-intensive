
resource "aws_instance" "example" {
  count = var.create_vm ? 1 : 0
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.vm_foreach.id] //[aws_security_group.vm.id]

  tags = {
    Name = var.instance_name
  }

  depends_on = [ 
    aws_security_group_rule.vm_count_ingress 
  ]
}