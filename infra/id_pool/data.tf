data "terraform_remote_state" "user_pool" {
  backend = "local"

  config = {
    path = "${path.module}/../user_pool/terraform.tfstate"
  }
}

