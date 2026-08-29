resource "aws_iam_user" "user" {
  for_each   = var.user
  name       = each.key
}

resource "aws_iam_user_group_membership" "group_membership" {
  for_each   = var.user
  user       = aws_iam_user.user[each.key].name
  groups     = each.value
  depends_on = [aws_iam_group.group, aws_iam_user.user]
}

resource "aws_iam_user_login_profile" "user_login" {
  for_each                = var.user
  user                    = aws_iam_user.user[each.key].name
  password_reset_required = true
  depends_on              = [aws_iam_group.group, aws_iam_user.user]
}

resource "aws_iam_group" "group" {
  for_each = var.group
  name     = each.value
}

resource "aws_iam_user_policy" "user_policy" {
  for_each = var.user_policy
  user     = each.key
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      for statement in each.value : {
        Effect = statement.Effect
        Action = statement.Action
        Resource = aws_iam_user.user[each.key].arn }] }
  )  
  depends_on = [aws_iam_user.user]
  
}

resource "aws_iam_group_policy" "group_policy" {
  for_each = var.group_policy
  group    = each.key
  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = each.value
  })
  depends_on = [aws_iam_group.group]


}

resource "aws_iam_role" "role" {
  for_each = var.role
  name     = each.key
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = each.value
  })
}

resource "aws_iam_policy" "policy" {
  for_each = var.policy
  name     = each.key
  policy = jsonencode({
    version = each.value.version
    Statement = each.value.statement
  })

}

resource "aws_iam_role_policy_attachment" "role_attachment" {
  for_each   = var.role_attachment
  role       = aws_iam_role.role[each.value.role_name].name
  policy_arn = aws_iam_policy.policy[each.value.policy_name].arn
}

