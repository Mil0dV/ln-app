# Creates a DO instance with Docker + the LN app
resource "digitalocean_droplet" "ln-app" {
  image = "ubuntu-14-04-x64"
  name = "ln-app"
  region = "ams3"
  size = "512mb"
  ssh_keys = [ "${digitalocean_ssh_key.deployer.fingerprint}" ]
  connection {
    user = "root"
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
      "echo ${digitalocean_droplet.ln-redis.ipv4_address} > redis_host",
      "cat redis_host",
      /* Build container */
      "cd /opt/ln-docker && sudo docker build -t lame/app .",
      "sudo docker run --name ln-app -t -i lame/app"
    ]
  }
}
