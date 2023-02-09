# output "ec2_arn" {
#   value = aws_instance.ec2.arn
# }
output "ec2_instance_state" {
  value = aws_instance.terra-ec2.instance_state
}
output "ec2_public_dns" {
  value = aws_instance.terra-ec2.public_dns
}

output "instance_id" {
  value = aws_instance.terra-ec2.id
}

output "instance_public_ip" {
  value = aws_instance.terra-ec2.public_ip
}

# output "ami_id" {
#   value = data.aws_ami.ubuntu.id
# }
