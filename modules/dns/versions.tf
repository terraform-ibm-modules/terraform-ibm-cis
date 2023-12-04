
terraform {
  required_version = ">= 1.3.0, <1.6.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.49.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}
