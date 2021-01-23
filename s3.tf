resource "aws_s3_bucket" "mybucketb39000123" {
  bucket = "mybucketb39000123"
  acl    = "private"

  tags = {
    name = "mybucketb39000123"
  }
}