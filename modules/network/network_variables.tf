variable "vpc" {
  type = map(object({
    cidr_block       = string
    instance_tenancy = string

    tags = map(string)
  }))
}

variable "subnet" {
  type = map(object({
    vpc_name          = string
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))
}

variable "igw" {
  type = map(object({
    vpc_name = string

    tags = map(string)
  }))
}

variable "route_table" {
  type = map(object({
    vpc_name = string
  }))
}

variable "route" {
  type = map(object({
    route_name       = string
    destination_cidr = string
    gateway_name     = string
  }))
}

variable "route_table_association" {
  type = map(object({
    subnet_name      = string
    route_table_name = string
  }))
}

variable "security_group" {
  type = map(object({
    vpc = string

    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
