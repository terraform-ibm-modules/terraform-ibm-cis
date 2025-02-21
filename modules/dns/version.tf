
terraform {
  required_version = ">= 1.9.0"

  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.70.0, < 2.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }
  }
}
