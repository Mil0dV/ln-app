# Creates a DO instance with Redis
resource "digitalocean_droplet" "ln-redis" {
  image = "ubuntu-14-04-x64"
  name = "ln-redis"
  region = "ams3"
  size = "512mb"
  ssh_keys = [ "${digitalocean_ssh_key.deployer.fingerprint}" ]
  connection {
    user = "root"
    key_file = "deploy-key"
  }
  provisioner "remote-exec" {
    inline = [
      /* Install docker */
      "curl -sSL https://get.docker.com/ubuntu/ | sudo sh",
      /* Initialize ruby container */
      "sudo docker run -d --name ln-redis redis"
    ]
  }
}
