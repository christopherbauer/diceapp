variable "environment" {
  type        = string
  description = "The target environment for the deployment of the ECS cluster"
}
variable "vpc_id" {
  type        = string
  description = "The target vpc id for the deployment"
}
variable "iam_container_management_arn" {
  type        = string
  description = "The arn of the iam role that handles esc deployment/execution"
}
variable "app_name" {
  type        = string
  description = "The app name for the app deployment that ECS is managing"
}
variable "image_name" {
  type        = string
  description = "The image name from ecr"
}
variable "internet_gateway_id" {
  type        = string
  description = "The internet gateway id to use"
}
variable "availability_zone_1" {
  type        = string
  description = "AWS availability zone"
}
variable "public_availability_zone_1_cidr" {
  type        = string
  description = "Public availability zone 1 CIDR block"
}
variable "private_availability_zone_1_cidr" {
  type        = string
  description = "Private availability zone 1 CIDR block"
}

variable "availability_zone_2" {
  type        = string
  description = "AWS availability zone"
}
variable "public_availability_zone_2_cidr" {
  type        = string
  description = "Public availability zone 2 CIDR block"
}
variable "private_availability_zone_2_cidr" {
  type        = string
  description = "Private availability zone 2 CIDR block"
}
variable "egress_security_group_id" {
  type        = string
  description = "Outbound security group"
}
variable "ingress_security_group_id" {
  type        = string
  description = "Inbound security group"
}
variable "http_security_group_id" {
  type        = string
  description = "Http security group"
}
variable "https_security_group_id" {
  type        = string
  description = "Https security group"
}
variable "environment_variables" {
  type        = list(object({ name = string, value = string }))
  description = "Service environment variables"
}
variable "container_port" {
  type        = number
  description = "Service container port"
}
variable "log_region" {
  type        = string
  description = "Cloudwatch log region"
}
variable "instance_cpu" {
  description = "Either a string of VCPUs or a number representing cpu units"
  default     = 256
}
variable "instance_memory" {
  type        = string
  description = "A string representing memory in MiB"
  default     = "1024"
}
variable "desired_instance_count" {
  type        = number
  description = "Desired number of instances to be running at all times"
  default     = 1
}
