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
  type = map(list(object({
    role          = string
    database_name = string
    bucket        = string
    folder        = string
  })))

}

variable "athena" {
  type = map(object({
    bucket = string
    folder = string
  }))

}


