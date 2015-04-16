# Creates a DO instance with Haproxy
resource "digitalocean_droplet" "ln-lb" {
  image = "ubuntu-14-04-x64"
  name = "ln-lb"
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
      "export PATH=$PATH:/usr/bin",
      # install haproxy 1.5
      "sudo add-apt-repository -y ppa:vbernat/haproxy-1.5",
      "sudo apt-get update",
      "sudo apt-get -y install haproxy"
    ]
  }

  provisioner "file" {
    source = "lb/haproxy.cfg"
    destination = "/etc/haproxy/haproxy.cfg"
  }

  provisioner "remote-exec" {
    inline = [
      # replace ip address variables in haproxy conf to use droplet ip addresses
      "sudo sed -i 's/LB_PUBLIC_IP/${digitalocean_droplet.ln-lb.ipv4_address}/g' /etc/haproxy/haproxy.cfg",
      "sudo sed -i 's/APP_1_PRIVATE_IP/${digitalocean_droplet.ln-app.0.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",
      "sudo sed -i 's/APP_2_PRIVATE_IP/${digitalocean_droplet.ln-app.1.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",
      # restart haproxy to load changes
      "sudo service haproxy restart"
    ]
  }
}
