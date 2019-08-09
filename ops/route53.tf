resource "aws_route53_zone" "bitelio-com-public" {
  name = "bitelio.com"
  comment = ""
}

resource "aws_route53_record" "bitelio-com-A" {
  zone_id = "Z55UFJUSNXP2N"
  name = "bitelio.com"
  type = "A"

  alias {
    name = "d1ne4wzzp1ik1q.cloudfront.net"
    zone_id = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "bitelio-com-NS" {
  zone_id = "Z55UFJUSNXP2N"
  name = "bitelio.com"
  type = "NS"
  records = ["ns-1778.awsdns-30.co.uk.", "ns-934.awsdns-52.net.", "ns-1478.awsdns-56.org.", "ns-429.awsdns-53.com."]
  ttl = "172800"
}

resource "aws_route53_record" "bitelio-com-SOA" {
  zone_id = "Z55UFJUSNXP2N"
  name = "bitelio.com"
  type = "SOA"
  records = ["ns-1478.awsdns-56.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl = "900"
}

resource "aws_route53_record" "_40cdaec37a94cd19808135404a224015-bitelio-com-CNAME" {
  zone_id = "Z55UFJUSNXP2N"
  name = "_40cdaec37a94cd19808135404a224015.bitelio.com"
  type = "CNAME"
  records = ["_af76a6f80848ff7abfcc1aa11990dc9c.hkvuiqjoua.acm-validations.aws."]
  ttl = "300"
}

resource "aws_route53_record" "www-bitelio-com-A" {
  zone_id = "Z55UFJUSNXP2N"
  name = "www.bitelio.com"
  type = "A"

  alias {
    name = "d1ne4wzzp1ik1q.cloudfront.net"
    zone_id = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "_316cf624d6e0ae3892468c01c5afff41-www-bitelio-com-CNAME" {
  zone_id = "Z55UFJUSNXP2N"
  name = "_316cf624d6e0ae3892468c01c5afff41.www.bitelio.com"
  type = "CNAME"
  records = ["_42ae1ec0157ae4c7d45676813e31ab66.hkvuiqjoua.acm-validations.aws."]
  ttl = "300"
}
