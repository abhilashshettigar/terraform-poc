resource "aws_instance" "ec2Instance" {
  ami = "ami-07651f0c4c315a529"
  instance_type = var.instanceType
  subnet_id = var.privateSubnet
  tags = {
    Name = "${var.name}-t2.Nano-${var.environment}"
  }
}


output "ec2InstancePrivateIp" {
  value = aws_instance.ec2Instance.private_ip
}