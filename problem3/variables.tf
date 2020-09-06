variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "ap-southeast-1"
}


#variable "private_key_path" {
#  description = "Path to file containing private key"
#  default     = "/home/centos/.ssh/id_rsa"
#}
