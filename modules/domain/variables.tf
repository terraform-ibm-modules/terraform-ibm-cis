
variable "cis_instance_id" {
  type        = string
  description = "CRN of the existing CIS instance."
}

variable "domain_name" {
  type        = string
  description = "The domain name to be added to the CIS instance."
}

variable "domain_type" {
  type        = string
  description = "The type of domain for the CIS instance: full or partial. Default value is full for regular domains."
  default     = "full"
  validation {
    condition     = contains(["full", "partial"], var.domain_type)
    error_message = "Provided value of domain_type is not alllowed."
  }
}
