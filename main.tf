terraform {
  backend "remote" {
    token = "zp3j0bEhwVvQJw.atlasv1.XMtyrxcSOisNTvGRIww8wugyZSUOw0jIMzL1BXzXIqJD7aUq5xwVMyXXXgjj731pwLI"
    hostname = "app.terraform.io"
    organization = "SomeCloudDude"

    workspaces {
      name = "vpc-test"
    }
  }
}

data "vault_generic_secret" "creds" {
  vault_addr = "https://vault.someclouddude.com:8200"
  path = "aws/kv/someclouddude"
}

provider "aws" {
  access_key = "${data.vault_generic_secret.creds.data[access_key_id]}"
  secret_key = "${data.vault_generic_secret.creds.data[secret_access_key]}"
  region = "us-east-1"
}
