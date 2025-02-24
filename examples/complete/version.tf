terraform {
  required_version = ">= 1.9.0"

  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.70.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.10.0"
    }
  }
}
