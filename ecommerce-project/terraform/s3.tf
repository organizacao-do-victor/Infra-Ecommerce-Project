resource "aws_s3_bucket" "ecommerce" {
  bucket = "ecommerce-as4d4ewf4wsaxasf5f23ergsax4er62d"
}

resource "aws_s3_bucket_public_access_block" "ecommerce" {
  bucket = aws_s3_bucket.ecommerce.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
