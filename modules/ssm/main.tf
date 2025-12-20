resource "aws_ssm_parameter" "sonar_token" {
  name  = "/cicd/sonar/sonar-token"
  type  = "SecureString"
  value = var.sonar_token
}

resource "aws_ssm_parameter" "docker_username" {
  name  = "/cicd/docker-credentials/username"
  type  = "SecureString"
  value = var.docker_username
}