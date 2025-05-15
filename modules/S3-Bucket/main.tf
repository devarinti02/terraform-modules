resource "aws_s3_bucket" "module-bucket" {
  bucket = var.bucket_name
  tags = {
    name = var.bucket_name

  }
}

resource "aws_s3_bucket_versioning" "module-bucketVersioning" {
  bucket = aws_s3_bucket_versioning.module_bucket.id

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}
