# Creates a DO instance with Redis
resource "digitalocean_droplet" "ln-redis" {
  image = "ubuntu-14-04-x64"
  name = "ln-redis"
  region = "ams3"
  size = "512mb"
  private_networking = "true"
  ssh_keys = [ "${digitalocean_ssh_key.deployer.fingerprint}" ]
  connection {
    user = "root"
    key_file = "deploy-key"
  }
  provisioner "remote-exec" {
    inline = [
      /* Install docker */
      "sudo apt-get update && apt-get -qy install docker.io",
      /*"curl -sSL https://get.docker.com/ubuntu/ | sudo sh",*/
      /* Initialize ruby container */
      "sudo docker run -d -p=6379:6379 --name ln-redis redis"
      /* Allow web instance access to Redis */
      /*"sudo ufw allow proto tcp to ${self.ipv4_address_private} port 6379"*/
    ]
  }
}
