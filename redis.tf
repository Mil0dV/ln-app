# Create a container
# resource "docker_container" "foo" {
#    image = "${docker_image.ubuntu.latest}"
#    name = "foo"
#    must_run = "true"
#}

#resource "docker_image" "ubuntu" {
#    name = "ubuntu:latest"
#}

resource "aws_instance" "ln-redis" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  tags = {
    Name = "ln-redis"
  }
  connection {
    user = "ubuntu"
    key_file = "deploy-key"
  }
  provisioner "remote-exec" {
    inline = [
      /* Install docker */
      "curl -sSL https://get.docker.com/ubuntu/ | sudo sh",
      /* Initialize ruby container */
      "sudo docker run --name ln-redis redis"
    ]
  }
}
