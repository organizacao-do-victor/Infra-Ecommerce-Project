resource "aws_lb" "front-app-load-balancer" {
  name               = "front-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.front-app-sg.id]
  subnets = [
    aws_subnet.ecommerce-project-pub-1.id,
    aws_subnet.ecommerce-project-pub-2.id
  ]
}

resource "aws_lb_target_group" "front-app-target-group" {
  name        = "front-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ecommerce-project.id
  target_type = "instance"
}

resource "aws_lb_listener" "front-app-listener" {
  load_balancer_arn = aws_lb.front-app-load-balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front-app-target-group.arn
  }
}

resource "aws_lb_target_group_attachment" "front-app-target-group-attachment" {
  target_group_arn = aws_lb_target_group.front-app-target-group.arn
  target_id        = aws_instance.front-app-project.id
  port             = 3000
}
