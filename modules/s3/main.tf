resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.project_name}-artifacts-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_versioning" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  
  versioning_configuration {
    status = "Enabled"
  }
}