variable "s3_bucket" {
  type = map(object({
    bucket = string
  }))
}

variable "s3_bucket_versioning" {
  type = map(object({
    bucket = string
  }))
}

variable "glue_database" {
  type = set(string)
}

variable "crawler" {
  type = map(object({
    role          = string
    database = string
    bucket        = string
    folder        = string
  }))

}

variable "athena" {
  type = map(object({
    bucket = string
    folder = string
  }))

}

variable "glue_role" {
  type = map(string)
}
