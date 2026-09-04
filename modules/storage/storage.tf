resource "aws_s3_bucket" "s3_bucket" {
  for_each = var.s3_bucket

  bucket = each.value.bucket
}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  for_each = aws_s3_bucket.s3_bucket

  bucket = each.value.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_glue_catalog_database" "glue_database" {
  for_each = var.glue_database

  name = each.value
}

resource "aws_glue_crawler" "crawler" {
  for_each = var.crawler

  name = each.key

  role = var.glue_role[each.value.role]

  database_name = aws_glue_catalog_database.glue_database[each.value.database].name

  s3_target {
    path = "s3://${aws_s3_bucket.s3_bucket[each.value.bucket].bucket}/${each.value.folder}"
  }

  depends_on = [
    aws_glue_catalog_database.glue_database
  ]
}

resource "aws_athena_workgroup" "athena" {
  for_each = var.athena

  name = each.key

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.s3_bucket[each.value.bucket].bucket}/${each.value.folder}"
    }
  }
}


