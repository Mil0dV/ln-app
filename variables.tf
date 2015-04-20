# Configure the Docker provider
#provider "docker" {
#    host = "tcp://192.168.59.103:2376/"
#}

variable "do_token" {}

variable "redis_pwd"{}

provider "digitalocean" {
    token = "${var.do_token}"
}

variable "region"     {
  description = "DO region to host your network"
  default     = "AMS3"
}
