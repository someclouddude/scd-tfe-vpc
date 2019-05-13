data "vault_generic_secret" "creds" {
  vault_addr = "https://vault.someclouddude.com:8200"
  path = "aws/kv/someclouddude"
}

provider "aws" {
  access_key = "${data.vault_generic_secret.creds.data[access_key_id]}"
  secret_key = "${data.vault_generic_secret.creds.data[secret_access_key]}"
  region = "us-east-1"
}
