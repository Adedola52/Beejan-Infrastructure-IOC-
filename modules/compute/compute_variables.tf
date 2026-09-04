variable "instance" {
  type = map(object({
    instance_ami                    = string
    instance_type          = string
    vpc_security_group_ids = string
    subnet_id              = string
    iam_instance_profile   = string
  }))
}

variable "instance_profile" {
  type = map(object({
    role = string
  }))
}

variable "ecs_cluster" {
  type = set(string)
}

variable "ecs_task_definition" {
  type = map(object({
    family                   = string
    cpu                      = number
    memory                   = number
    network_mode             = string
    requires_compatibilities = list(string)

    image          = string
    container_name = string
    container_port = number

    execution_role = string
  }))
}

variable "subnet_ids" {
  type = map(string)
}

variable "security_group_ids" {
  type = map(string)
}

variable "role_names" {
  type = map(string)
}

variable "role_arns" {
  type = map(string)
}