terraform {
  backend "s3" {
    bucket = "swiggy-clone-state-bucket"
    key = "prod/terraform.tfstate"
    region = "ap-northeast-1"
  }
}