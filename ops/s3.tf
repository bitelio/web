resource "aws_s3_bucket" "bitelio-com" {
  bucket = "bitelio.com"
  region = "eu-central-1"
  website {
    index_document = "index.html"
  }
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::bitelio.com/*"
    }
  ]
}
POLICY

}

resource "aws_s3_bucket" "www-bitelio-com" {
  bucket = "www.bitelio.com"
  website {
    redirect_all_requests_to = "https://bitelio.com"
  }
}
