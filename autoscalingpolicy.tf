# scale up alarm

resource "aws_autoscaling_policy" "cpu-policy" {
  name                   = "cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.Appds_asg.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "600"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm" {
  alarm_name          = "cpu-alarm"
  alarm_description   = "Scale-up if CPU > 75% for 10 minutes"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "600"
  statistic           = "Average"
  threshold           = "75"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.Appds_asg.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.cpu-policy.arn}"]
}

# scale down alarm
resource "aws_autoscaling_policy" "cpu-policy-scaledown" {
  name                   = "cpu-policy-scaledown"
  autoscaling_group_name = "${aws_autoscaling_group.Appds_asg.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaledown" {
  alarm_name          = "cpu-alarm-scaledown"
  alarm_description   = "Scale-down if CPU < 60% for 5 minutes"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "60"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.Appds_asg.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.cpu-policy-scaledown.arn}"]
}