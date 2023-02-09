resource "aws_key_pair" "key-tf4" {
  key_name   = "key-tf4"
  public_key = file("${path.module}/id_rsa.pub")

}