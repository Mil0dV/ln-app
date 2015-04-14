# Create a container
# resource "docker_container" "foo" {
#    image = "${docker_image.ubuntu.latest}"
#    name = "foo"
#    must_run = "true"
#}

#resource "docker_image" "ubuntu" {
#    name = "ubuntu:latest"
#}


resource "aws_instance" "example" {
    ami = "ami-96c41ce1"
    instance_type = "t2.micro"
}
