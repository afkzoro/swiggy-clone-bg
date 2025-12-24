variable "sonar_token" {
  description = "Sonarqube token"
  type = string
}

variable "docker_username" {
  description = "Docker username"
  type = string
}

variable "docker_password" {
  description = "Docker password or access token"
  type = string
  sensitive = true
}