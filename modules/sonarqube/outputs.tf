output "instance_id" {
  description = "ID of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube.id
}

output "public_ip" {
  description = "Public IP address of the SonarQube instance"
  value       = aws_instance.sonarqube.public_ip
}

output "sonarqube_url" {
  description = "URL to access SonarQube"
  value       = "http://${aws_instance.sonarqube.public_ip}:9000"
}

output "security_group_id" {
  description = "ID of the SonarQube security group"
  value       = aws_security_group.sonarqube.id
}
