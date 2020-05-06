output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "user_pool_endpoint" {
  value = aws_cognito_user_pool.user_pool.endpoint
}


output "app_client_id" {
  value = aws_cognito_user_pool_client.client.id
}