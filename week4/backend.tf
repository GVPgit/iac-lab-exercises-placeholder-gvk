terraform {
  backend "s3" {
    bucket  = "mys3gvk"
    key     = "terraform.tfstate"
    region  = "ap-southeast-2"
    profile = "twbeach"

    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
}
