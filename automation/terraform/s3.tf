resource "aws_s3_bucket" "ecommerce" {
  bucket = "ecommerce-${random_uuid.uuid.result}"
  force_destroy = true
}

resource "random_uuid" "uuid" {

}

resource "aws_s3_bucket_public_access_block" "ecommerce" {
  bucket = aws_s3_bucket.ecommerce.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

