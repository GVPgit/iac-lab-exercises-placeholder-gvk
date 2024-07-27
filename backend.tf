terraform {
  backend "s3" {
    bucket = "mys3gvk"
    key    = "terraform.tfstate"
    region = "ap-southeast-2"

    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
}
