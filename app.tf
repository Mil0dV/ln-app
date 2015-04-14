# Creates an AWS instance with Docker + the LN app
resource "aws_instance" "ln-app" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}"]
  key_name = "${aws_key_pair.deployer.key_name}"
  source_dest_check = false
  tags = {
    Name = "ln-app"
  }
  connection {
    user = "ubuntu"
    key_file = "deploy-key"
  }
  provisioner "file" {
    source = "app/Dockerfile"
    destination = "/opt/ln-docker"
  }
  provisioner "remote-exec" {
    inline = [
      /* Install docker */
      "curl -sSL https://get.docker.com/ubuntu/ | sudo sh",
      /* Provide Redis IP to app */
      "echo ${aws_instance.ln-redis.public_ip} > redis_host",
      "cat redis_host",
      /* Build container */
      "cd /opt/ln-docker && sudo docker build -t lame/app .",
      "sudo docker run --name ln-app -t -i lame/app"
    ]
  }
}
