terraform {
  required_version = ">= 1.3.0, <1.6.0"

  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.10.0"
    }
  }
}
