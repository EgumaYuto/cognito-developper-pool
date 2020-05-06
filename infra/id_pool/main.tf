module "id_label" {
  source = "../_module/label"
  name   = local.pool_name
}

resource "aws_cognito_identity_pool" "id_pool" {
  identity_pool_name = module.id_label.name
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id              = data.terraform_remote_state.user_pool.outputs.app_client_id
    provider_name = data.terraform_remote_state.user_pool.outputs.user_pool_endpoint
    server_side_token_check = false
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "auth_role" {
  identity_pool_id = aws_cognito_identity_pool.id_pool.id
  roles = {
    authenticated = aws_iam_role.auth_user_role.arn
  }
}