resource "aws_s3_bucket" "state-files" {
  bucket = "terraform-state-gitops"

  versioning {
    enabled = true
  }
  tags = {
    Name = "terraform-state-gitops"
  }
}