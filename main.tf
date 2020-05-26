/*
 * Module: tf_aws_asg_elb
 *
 * This template creates the following resources
 *   - A launch configuration
 *   - A auto-scaling group
 * * It requires you create an ELB instance before you use it.
 */

provider "aws" {
        region = "${var.region}"
        access_key = "${var.aws_access_key}"
        secret_key = "${var.aws_secret_key}"

}

data "template_file" "init"{
  template = "${file("${var.user_data_path}")}"
}

# refer: https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
resource "aws_launch_configuration" "launch_config" {
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  security_groups  = ["${var.security_groups}"]
  iam_instance_profile = "${var.iam_instance_profile}"
  # associate_public_ip_address = true 
  user_data = "${data.template_file.init.rendered}"


  lifecycle              { 
	create_before_destroy = true 
	}
}
# refer : https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "Appds_asg" {
  # We want this to explicitly depend on the launch config above
  # depends_on = ["aws_launch_configuration.launch_config"]
  name  = "${var.asg_name}"

  tags = ["${concat(
    list(
      map("key", "Name", "value", "${var.lc_name}", "propagate_at_launch", true),
      map("key", "ResourceOwner", "value", "sai Doppalapudi ", "propagate_at_launch", true),
      map("key", "CostCenter", "value", "78-900", "propagate_at_launch", true),
      map("key", "Application", "value", "CLOUD-POC", "propagate_at_launch", true)
    ))
  }"]

  # Uses the ID from the launch config created above or it can be launch_config.name
  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  vpc_zone_identifier  = ["${var.vpc_subnets_ids}"]

  max_size = "${var.asg_max_number_of_instances}"
  min_size = "${var.asg_minimum_number_of_instances}"
  desired_capacity     = "${var.desired_capacity}"

  target_group_arns = ["${aws_lb_target_group.ag_target1.arn}"]
  # force_delete = true

}

/*
*resource "aws_instance" "Appds-DB" {
*       ami = "${var.ami}"
*       instance_type = "${var.db_instance_type}"
*	      vpc_subnets_ids = ["${var.vpc_subnets_ids}"]
*        key_name = "${var.key_name}"
*        vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
*        tags = "${merge(
*            local.common_tags,
*            map(
*             "Name", "${var.DB_name}"
*            )
*        )}"
*        user_data = "${file(var.DB_user_data)}" 
*}
*/

resource "aws_route53_record" "cname_route53_record" {
  depends_on = ["aws_lb.alb_app"]
  zone_id = "${var.DNSHostedZone_id}" # Replace with your zone ID
  name    = "dev.${var.DNSHostedZone}" # Replace with your name/domain/subdomain
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_lb.alb_app.dns_name}"]
}

output "DNSRecord" {
  value = "${aws_route53_record.cname_route53_record.name}"
}
