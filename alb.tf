#TG
# refer: https://www.terraform.io/docs/providers/aws/r/lb_target_group.html
resource "aws_lb_target_group" "ag_target1" {
  name     = "${var.ag_target}"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  health_check {
      interval = 30
      timeout  = 5
      healthy_threshold  = 3
      unhealthy_threshold  = 5
	
  }


  
}

resource "aws_lb" "alb_app" {
  name            = "alb-app"
  subnets     = ["${var.vpc_subnets_ids}"]
  internal = true
  security_groups = ["${var.security_groups}"]
}

resource "aws_lb_listener" "front_end_80" {
  load_balancer_arn = "${aws_lb.alb_app.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.ag_target1.arn}"
    type             = "forward"
  }
}
/* resource "aws_lb_listener" "front_end_443" {
  load_balancer_arn = "${aws_lb.alb_app.id}"
  port              = "443"
  protocol          = "HTTPS"
  default_action {
    target_group_arn = "${aws_lb_target_group.ag_target1.arn}"
    type             = "forward"
  }
} */