# create DynamoDB table for locking state
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "enricco-terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "enricco-terraform-state-lock"
  }

  depends_on = [aws_s3_bucket.s3_bucket]
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "enricco-terraform-state"

  tags = {
    Name = "enricco-terraform-state"
  }
}

provider "aws" {
  region = "eu-west-1"
}
