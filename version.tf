terraform {
  required_version = ">= 1.9.0"

  # Use a flexible range in modules that future proofs the module's usage with upcoming minor and patch versions
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.79.0, < 2.0.0"
    }
  }
}
