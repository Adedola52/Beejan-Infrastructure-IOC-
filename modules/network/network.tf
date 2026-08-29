resource "aws_vpc" "vpc" {
  for_each = var.vpc

  cidr_block       = each.value.cidr_block
  instance_tenancy = each.value.instance_tenancy

  tags = each.value.tags

}

resource "aws_subnet" "subnet" {
  for_each = var.subnet


  vpc_id     = aws_vpc.vpc[each.value.vpc_name].id
  cidr_block = each.value.cidr_block

  tags = each.value.tags

  depends_on = [aws_vpc.vpc]
}

resource "aws_internet_gateway" "igw" {
  for_each = var.igw

  vpc_id = aws_vpc.vpc[each.value.vpc_name].id
  tags   = each.value.tags

  depends_on = [aws_vpc.vpc]
}


resource "aws_route" "route" {
  for_each = var.route

  route_table_id = aws_route_table.route_table[each.value.route.route_name].id

  destination_cidr_block = each.value.destination_cidr

  gateway_id = aws_internet_gateway.igw[each.value.gateway_name].id

  depends_on = [aws_internet_gateway.igw, aws_route_table.route_table]
}

resource "aws_route_table" "route_table" {
  for_each = var.route_table

  vpc_id = aws_vpc.vpc[each.value.vpc_name].id

  depends_on = [aws_vpc.vpc]

}

resource "aws_route_table_association" "route_table_association" {
  for_each = var.route_table_association

  subnet_id      = aws_subnet.subnet[each.value.subnet_name].id
  route_table_id = aws_route_table.route_table[each.value.route_table_name].id

  depends_on = [aws_subnet.subnet, aws_route_table.route_table]
}

resource "aws_security_group" "security_group" {
  for_each = var.security_group

  name   = each.key
  vpc_id = aws_vpc.vpc[each.value.vpc].id

  dynamic "ingress" {
    for_each = each.value.ingress

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

