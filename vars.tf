variable "region" {
  description = "The region you waant to launch"
  default = "us-west-2"
}

variable "aws_access_key" {
  description = "The accesskey of the user"
  default = "xxxxxxxxxxxxxxxxxxxxxx"
}

variable "aws_secret_key" {
  description = "The secretkey you want to login"
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

# Launch config

variable "vpc_id" {
  description = "The Vpc id"
  default = "vpc-xxxxxxxxx"
}

variable "lc_name" {
  description = "name of the instance launched"
  default = "webserver"
}

variable "image_id" {
  description = "ID of AMI to use for the instance"
  default = "ami-xxxxxxxxxx"
}

variable "instance_type" {
  description = "The type of instance to start"
  default = "t3.large"
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = "it-user"
}


variable "iam_instance_profile" {
  description = "The IAM Profile to use for the instance"
  default     = "Devops-EC2-S3"
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the launch configuration"
  type        = "list"
  default = ["sg-xxxxxxxxxx", "sg-xxxxxxxxx"]
}


variable "user_data_path" {
  default = "./user_data.txt"
}



variable "vpc_subnets_ids" {
  description = "A list of subnet IDs to associate with"
  type        = "list"
  default = ["subnet-xxxxxxxxxxx", "subnet-xxxxxxxxxxx"]
}

# DATABASE (APPDS)
/*
* variable "DB_name" {
*   description = "name of the DB instance launched"
*   default = "DATABASE"
*}
* variable "db_instance_type" {
*  description = "The type of instance to start Database"
*  default = "t2.large"
*}
* variable "DB_user_data_file" {
*  default = "web-user-data.ps1"
*}
*/

# ASG

variable "asg_name" {
  description = "name of the ASG"
  default = "ASG"
}

variable "asg_max_number_of_instances" {
  description = "Maximum number of instance in ASG"
  default = 2
}

variable "asg_minimum_number_of_instances" {
  description = "Minimum number of instances in ASG"
  default = 1
}

variable "desired_capacity" {
  description = "Minimum number of instances in ASG"
  default = 1
}


variable "ag_target" {
  default = "targetgroup"
}

# Route53
variable "DNSHostedZone_id" {
  default = "xxxxxxxxxxxxxxxx"
}

variable "DNSHostedZone" {
  default = "nonprod.aws.com."
}

