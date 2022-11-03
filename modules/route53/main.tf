resource "aws_route53_zone" "zone" {
  name = "geo-terraform-test.com"
  vpc {
    vpc_id  = var.vpcId
  }
  tags = {
    "Name"        = "${var.name}"
    "Environment" = "${var.environment}"
  }
}

resource "aws_route53_record" "record" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "instance-test.geo-terraform-test.com"
  type    = "A"
  ttl     = 60
  records = [var.ec2InstancePrivateIp]
}
