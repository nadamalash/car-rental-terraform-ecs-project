# create application load balancer
resource "aws_lb" "application_load_balancer" {
  name                       = "${var.project_name}-${var.environment}-alb"
  internal                   = false  # true means the ALB will be accessible only from your VPC and external clients on the internet won't be able to access it directly.
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_security_group.id]
  subnets                    = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]
  enable_deletion_protection = false  # true means that the ALB is protected from being deleted accidentally, this can be useful to prevent critical infrastructure. 

  tags = {
    Name = "${var.project_name}-${var.environment}-alb"
  }
}

# create target group
resource "aws_lb_target_group" "alb_target_group" {
  name        = "${var.project_name}-${var.environment}-tg"
  target_type = "ip"  #"ip" if you're using IP addresses instead of EC2 instances
  port        = 80  
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    healthy_threshold   = 5  #number of consecutive successful health checks required before considering an instance as healthy
    interval            = 30 #health check is performed every 30 seconds
    matcher             = "200,301,302" #response codes that indicate a healthy response [string that contains a comma-separated list of HTTP response codes]. In this example, the instance is considered healthy if it responds with HTTP status codes 200, 301, or 302.
    path                = "/" # destination for the health check request. In this case, the health check is performed on the root ("/") path of the application.
    port                = "traffic-port" #The value "traffic-port" refers to the same port as the target group. This is a dynamic value that matches the port used for routing traffic to the instances in the target group.
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

# create a listener on port 80 [HTTP] with forward action [incoming requests to the specified target group without any redirection].
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

/*
# We don't have certificare so it wouldn't work
# create a listener on port 443 with forward action (tirrafic come from http listener with redirect action)
resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = "" 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}*/
