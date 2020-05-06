module "pool_label" {
  source = "../_module/label"
  name   = local.pool_name
}

module "client_label" {
  source = "../_module/label"
  name   = local.client_name
}

resource "aws_cognito_user_pool" "user_pool" {
  name = module.pool_label.name
}

resource "aws_cognito_user_pool_client" "client" {
  name                   = module.client_label.name
  user_pool_id           = aws_cognito_user_pool.user_pool.id
  refresh_token_validity = local.refresh_token_validity
  explicit_auth_flows = [
    "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  prevent_user_existence_errors = "ENABLED"
}