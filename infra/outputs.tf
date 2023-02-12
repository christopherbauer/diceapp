
output "deploy_key" {
  value     = aws_iam_access_key.deploy_key
  sensitive = true
}
output "deploy_secret" {
  value     = aws_iam_access_key.deploy_key.encrypted_secret
  sensitive = true
}

output "development_diceapp_url" {
  value = module.development.development_diceapp_api_url
}
