resource "aws_vpc" "swiggy-clone-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.swiggy-clone-vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.swiggy-clone-vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip

  tags = {
    Name = "${var.project_name}-${each.key}"
    Type = "public"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id                  = aws_vpc.swiggy-clone-vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${each.key}"
    Type = "private"
  }
}

# Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
  for_each = var.enable_nat_gateway ? (var.single_nat_gateway ? { for k in [element(keys(var.public_subnets), 0)] : "single" => k } : { for k, v in var.public_subnets : k => k }) : {}

  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip-${each.key}"
  }

  depends_on = [aws_internet_gateway.igw]
}

# NAT Gateways
resource "aws_nat_gateway" "nat" {
  for_each = var.enable_nat_gateway ? (var.single_nat_gateway ? { for k in [element(keys(var.public_subnets), 0)] : "single" => k } : { for k, v in var.public_subnets : k => k }) : {}

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.value].id

  tags = {
    Name = "${var.project_name}-nat-${each.key}"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.swiggy-clone-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Private Route Tables
resource "aws_route_table" "private" {
  for_each = var.enable_nat_gateway ? (var.single_nat_gateway ? { "single" = "single" } : { for k, v in var.private_subnets : k => k }) : { "default" = "default" }

  vpc_id = aws_vpc.swiggy-clone-vpc.id

  dynamic "route" {
    for_each = var.enable_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = var.single_nat_gateway ? aws_nat_gateway.nat["single"].id : aws_nat_gateway.nat[each.key].id
    }
  }

  tags = {
    Name = "${var.project_name}-private-rt-${each.key}"
  }
}

# Private Route Table Association
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = var.single_nat_gateway ? aws_route_table.private["single"].id : aws_route_table.private[each.key].id
}