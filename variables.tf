# Configure the Docker provider
#provider "docker" {
#    host = "tcp://192.168.59.103:2376/"
#}

variable "mgt_subnets" {}

variable "do_token" {}

variable "redis_pwd"{}

provider "digitalocean" {
    token = "${var.do_token}"
}

variable "region"     {
  description = "AWS region to host your network"
  default     = "eu-west-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.0.0.0/24"
}

variable "amis" {
  description = "Ubuntu 14.04 AMI as starting point"
  default = {
    eu-west-1 = "ami-96c41ce1"
  }
}
