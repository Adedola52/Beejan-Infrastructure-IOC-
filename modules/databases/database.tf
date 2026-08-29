resource "aws_db_subnet_group" "subnet_group" {
  for_each = var.subnet_group

  name = each.key

  subnet_ids = [
    for subnet in each.value.subnets :
    var.subnet_ids[subnet]
  ]
}

resource "aws_db_instance" "rds" {
  for_each = var.rds

  identifier = each.key

  engine         = each.value.engine
  engine_version = each.value.engine_version

  instance_class    = each.value.instance_class
  allocated_storage = each.value.allocated_storage

  db_name  = each.value.db_name
  username = each.value.username
  password = each.value.password

  db_subnet_group_name = aws_db_subnet_group.subnet_group[
    each.value.subnet_group
  ].name

  vpc_security_group_ids = [
    var.security_group_ids[each.value.security_group]
  ]

  skip_final_snapshot = true
}