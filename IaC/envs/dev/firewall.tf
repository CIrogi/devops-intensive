data "aws_vpc" "default" {
	default = true
}

resource "aws_security_group" "vm" {
	name        = "${var.instance_name}-sg"
	description = "Security group for ${var.instance_name}"
	vpc_id      = data.aws_vpc.default.id

	dynamic "ingress" {
		for_each = toset(var.vm_firewall_ports)
		content {
			description = "Allow TCP ${ingress.value}"
			from_port   = ingress.value
			to_port     = ingress.value
			protocol    = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "${var.instance_name}-sg"
	}
}

resource "aws_security_group" "vm_map" {
	name        = "${var.instance_name}-sg-map"
	description = "Security group (map-driven) for ${var.instance_name}"
	vpc_id      = data.aws_vpc.default.id

	dynamic "ingress" {
		for_each = var.vm_firewall_ports_map
		content {
			description = "${ingress.key}: ${ingress.value.description}"
			from_port   = ingress.value.port
			to_port     = ingress.value.port
			protocol    = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "${var.instance_name}-sg-map"
	}
}

# Example using `count` with `var.vm_firewall_ports`
resource "aws_security_group" "vm_count" {
	name        = "${var.instance_name}-sg-count"
	description = "Security group (count-driven) for ${var.instance_name}"
	vpc_id      = data.aws_vpc.default.id

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "${var.instance_name}-sg-count"
	}
}

resource "aws_security_group_rule" "vm_count_ingress" {
	count             = length(var.vm_firewall_ports)
	type              = "ingress"
	security_group_id = aws_security_group.vm_count.id

	from_port   = var.vm_firewall_ports[count.index]
	to_port     = var.vm_firewall_ports[count.index]
	protocol    = "tcp"
	cidr_blocks = ["0.0.0.0/0"]

	description = "Allow TCP ${var.vm_firewall_ports[count.index]}"
}

# Example using `for_each` with `var.vm_firewall_ports_map`
resource "aws_security_group" "vm_foreach" {
	name        = "${var.instance_name}-sg-foreach"
	description = "Security group (for_each-driven) for ${var.instance_name}"
	vpc_id      = data.aws_vpc.default.id

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "${var.instance_name}-sg-foreach"
	}
}

resource "aws_security_group_rule" "vm_foreach_ingress" {
	for_each          = var.vm_firewall_ports_map
	type              = "ingress"
	security_group_id = aws_security_group.vm_foreach.id

	from_port   = each.value.port
	to_port     = each.value.port
	protocol    = "tcp"
	cidr_blocks = ["0.0.0.0/0"]

	description = "${each.key}: ${each.value.description}"
}



