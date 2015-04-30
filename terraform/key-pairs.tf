resource "digitalocean_ssh_key" "deployer" {
  name = "deploy-key"
  public_key = "${file(\"deploy-key.pub\")}"
}
