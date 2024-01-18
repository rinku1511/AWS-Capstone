

data "aws_route53_zone" "route53-zone" {
  name = "dns-poc-onprem.tk"
}

resource "aws_route53_record" "route53-record" {
  name    = var.record-name
  zone_id = data.aws_route53_zone.route53-zone.id
  type    = var.record-type
  ttl     = var.ttl
  records = [aws_cloudfront_distribution.cloudfront-distribution.domain_name]
}