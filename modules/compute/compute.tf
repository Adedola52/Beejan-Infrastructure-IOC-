resource "aws_instance" "instance" {
  for_each = var.instance

  ami           = each.value.instance_ami
  instance_type = each.value.instance_type

  subnet_id = var.subnet_ids[each.value.subnet]

  vpc_security_group_ids = [
    var.security_group_ids[each.value.security_group]
  ]

  iam_instance_profile = aws_iam_instance_profile.instance_profile[
    each.value.instance_profile
  ].name

}

resource "aws_iam_instance_profile" "instance_profile" {
  for_each = var.instance_profile

  name = each.key

  role = var.role_names[each.value.role]

  depends_on = [
    var.role_names
  ]
}

resource "aws_ecs_cluster" "ecs_cluster" {
  for_each = var.ecs_cluster

  name = each.value
}

resource "aws_ecs_task_definition" "task_definition" {
  for_each = var.ecs_task_definition

  family                   = each.value.family
  cpu                      = each.value.cpu
  memory                   = each.value.memory
  network_mode             = each.value.network_mode
  requires_compatibilities = each.value.requires_compatibilities

  execution_role_arn = var.role_arns[
    each.value.execution_role
  ]

  container_definitions = jsonencode([
    {
      name      = each.value.container_name
      image     = each.value.image
      essential = true

      portMappings = [
        {
          containerPort = each.value.container_port
          hostPort      = each.value.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}



