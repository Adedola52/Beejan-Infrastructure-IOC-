output "role_arns" {
  value = {
    for name, role in aws_iam_role.role :
    name => role.arn
  }
}

output "role_names" {
  value = {
    for name, role in aws_iam_role.role :
    name => role.name
  }
}

output "user_password" {
  value = { for user, profile in aws_iam_user_login_profile.user_login :
  user => profile.password }
  sensitive = true
}