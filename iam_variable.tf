variable "user" {
  type = map(list(string)
  )
  description = "This is a variable to provision aws user(s)"
}

variable "group" {
  type        = set(string)
  description = "This is a variable to provision aws group(s)"
}

variable "user_policy" {
  type = map(list(object({
    Effect   = string
    Action   = list(string)
    Resource = list(string)
  })))
  description = "This is a variable to provision user policy"
}

variable "group_policy" {
  type = map(list(object({
    Effect   = string
    Action   = list(string)
    Resource = list(string)
  })))
  description = "This is a variable to provision group policy"
}


variable "role" {
  type = map(list(object({
    Effect = string
    Principal = object({
      Service = list(string)
    })
    Action = list(string)

  })))
}


variable "policy" {
  type = map(list(object({
    version = string

    Statement = list(object({
      Effect = string
      Action = list(string)

      Resource = list(string)
    })) })


  ))
}

variable "role_attachment" {
  type = map(object({
    role_name   = string
    policy_name = string
  }))
}