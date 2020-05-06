provider "aws" {
  region  = "ap-northeast-1"
  version = "2.60.0"
  profile = "cabos-sandbox"
}

terraform {
  backend "local" {
  }
}