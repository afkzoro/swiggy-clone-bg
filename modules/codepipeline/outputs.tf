output "pipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.app.name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.app.arn
}

output "role_arn" {
  description = "ARN of the CodePipeline IAM role"
  value       = aws_iam_role.codepipeline_role.arn
}
