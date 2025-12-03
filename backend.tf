terraform {
  backend "s3" {
    bucket       = "custodyrox-terraformstate-file"
    key          = "state/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}
