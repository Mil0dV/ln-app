resource "aws_key_pair" "deployer" {
  key_name = "deploy-key"
  public_key = "${file(\"deploy-key.pub\")}"
}
