output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.artifacts.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.artifacts.arn
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.artifacts.bucket
}
