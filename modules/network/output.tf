output "subnet_ids" {
  value = {
    for name, subnet in aws_subnet.subnet :
    name => subnet.id
  }
}

output "security_group_ids" {
  value = {
    for name, sg in aws_security_group.security_group :
    name => sg.id
  }
}
