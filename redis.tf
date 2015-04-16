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

  provisioner "file" {
    source = "redis"
    destination = "/opt"
  }

  provisioner "remote-exec" {
    inline = [
      /* Install docker 1.4 for remote connections on 14.04 */
      "sudo apt-get update && apt-get -qy install docker.io",
      /* set Redis pw */
      "cd /opt/redis && sudo sed -i -e 's/foobared/${var.redis_pwd}/' redis.conf",
      /* Build and run Redis container */
      "sudo docker build -t lame/redis .",
      "sudo docker run -d -p=6379:6379 --name ln-redis lame/redis"
    ]
  }
}
