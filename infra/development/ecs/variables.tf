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
  type = string
}
variable "public_availability_zone_1_cidr" {
  type = string
}
variable "private_availability_zone_1_cidr" {
  type = string
}

variable "availability_zone_2" {
  type = string
}
variable "public_availability_zone_2_cidr" {
  type = string
}
variable "private_availability_zone_2_cidr" {
  type = string
}
variable "egress_security_group_id" {
  type = string
}
variable "ingress_security_group_id" {
  type = string
}
variable "http_security_group_id" {
  type = string
}
variable "https_security_group_id" {
  type = string
}
variable "environment_variables" {
  type = list(object({ name = string, value = string }))
}
variable region {
  type=string
}
variable "container_port" {
  type = number
}