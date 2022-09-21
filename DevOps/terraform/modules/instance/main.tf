# Create Security Group for Front-end
resource "aws_security_group" "this" {
  name        = local.frontend_sg_name
  description = "${local.resource_prefix} SG"
  vpc_id      = local.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = local.frontend_app_port
    to_port     = local.frontend_app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Create a launch configuration for application servers
resource "aws_launch_configuration" "this" {
  name                 = "${local.resource_prefix}-asg-lc"
  image_id             = local.instance_ami
  instance_type        = local.instance_type
  security_groups      = [aws_security_group.this.id]
  key_name = "faceit-keypair"

  user_data = data.template_file.lc_user_data.rendered
}


# Create an Auto Scaling Group with launch configuration
resource "aws_autoscaling_group" "this" {
  name                 = "${local.resource_prefix}-asg"
  max_size             = local.instance_asg_max
  min_size             = local.instance_asg_min
  desired_capacity     = local.instance_asg_desired
  force_delete         = true
  launch_configuration = aws_launch_configuration.this.name
  target_group_arns    = [aws_alb_target_group.this.arn]
  vpc_zone_identifier  = local.subnet_id

  tag {
    key                 = "Name"
    value               = "${local.resource_prefix}-Server"
    propagate_at_launch = "true"
  }
  lifecycle {
    create_before_destroy = true
  }
}

//# Create Application Load Balancer for frontend server
resource "aws_lb" "frontend_alb" {
  name                       = "${local.resource_prefix}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.this.id]
  enable_deletion_protection = false
  subnets                    = local.subnet_id
}

# Create Health check for ALB target
resource "aws_alb_target_group" "this" {
  name                 = "${local.resource_prefix}-target-group"
  port                 = local.frontend_app_port
  protocol             = "HTTP"
  vpc_id               = local.vpc_id
  deregistration_delay = 60

  health_check {
    interval            = 5
    path                = var.hc_path
    protocol            = var.hc_protocol
    timeout             = 2
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-299,403"
  }
}

data "template_file" "lc_user_data" {
  template = file("${path.module}/user_data.sh")
  vars = {
    html_input = file("${path.module}/html/question1.html")
  }
}


resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = local.frontend_app_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}