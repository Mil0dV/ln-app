# Creates a DO instance with Docker + the LN app
resource "digitalocean_droplet" "ln-app" {
  count = 2
  image = "ubuntu-14-04-x64"
  name = "ln-app${count.index+1}"
  region = "${var.region}"
  size = "512mb"
  private_networking = "true"
  ssh_keys = [ "${digitalocean_ssh_key.deployer.fingerprint}" ]
  connection {
    user = "root"
    key_file = "deploy-key"
  }
  provisioner "remote-exec" {
    inline = [
    # Create dir
    "sudo mkdir -p /opt/ln-docker"
    ]
  }
  provisioner "file" {
    source = "app/Dockerfile"
    destination = "/opt/ln-docker/Dockerfile"
  }
  provisioner "remote-exec" {
    inline = [
      # Install docker
      "curl -sSL https://get.docker.com/ubuntu/ | sudo sh",
      # Provide Redis pass and IP to app
      "cd /opt/ln-docker",
      "echo :${var.redis_pwd}@${digitalocean_droplet.ln-redis.ipv4_address_private} > redis_host",
      # Build and run container
      "sudo docker build -t lame/app .",
      "sudo docker run -d -p=80:8080 --name ln-app -t -i lame/app"
    ]
  }
}