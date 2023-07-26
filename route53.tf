resource "aws_route53_zone" "private" {
    name = "tmc-sandbox.com"
    vpc {
      vpc_id = aws_vpc.TKGVPC.id
    }
  
}

resource "aws_route53_record" "harbor-record" {
  zone_id = aws_route53_zone.private.zone_id
  name = "harbor"
  type = "A"
  ttl = 1000
  


  records = [ aws_instance.harbor.public_ip ]
}