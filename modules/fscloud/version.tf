terraform {
  required_version = ">= 1.3.0, <1.7.0"

  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.63.0, < 2.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.10.0"
    }
  }
}
