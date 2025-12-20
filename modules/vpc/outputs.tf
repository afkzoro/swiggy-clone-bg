output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.swiggy-clone-vpc.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.swiggy-clone-vpc.cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "public_subnets" {
  description = "Map of public subnets"
  value       = aws_subnet.public
}

output "private_subnets" {
  description = "Map of private subnets"
  value       = aws_subnet.private
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = [for nat in aws_nat_gateway.nat : nat.id]
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "List of private route table IDs"
  value       = [for rt in aws_route_table.private : rt.id]
}