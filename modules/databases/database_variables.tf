variable "subnet_group" {
  type = map(object({
    subnets = list(string)
  }))
}

variable "rds" {
  type = map(object({
    engine         = string
    engine_version = string
    instance_class = string

    allocated_storage = number

    db_name  = string
    username = string
    password = string

    subnet_group   = string
    security_group = string
  }))
}

variable "subnet_ids" {
  type = map(string)
}

variable "security_group_ids" {
  type = map(string)
}