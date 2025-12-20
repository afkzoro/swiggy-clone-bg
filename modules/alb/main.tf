resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  vpc_id      = var.vpc_id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "blue" {
  name     = "${var.project_name}-tg-blue"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
  }
  
  tags = {
    Name = "${var.project_name}-tg-blue"
  }
}

resource "aws_lb_target_group" "green" {
  name     = "${var.project_name}-tg-green"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
  }
  
  tags = {
    Name = "${var.project_name}-tg-green"
  }
}

# ALB Listener (initially points to blue target group)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}