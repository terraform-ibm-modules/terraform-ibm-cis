
variable "cis_instance_id" {
  type        = string
  description = "CRN of an existing CIS instance."
}

variable "domain_name" {
  type        = string
  description = "DNS domain name to add to the CIS instance."
}

variable "domain_type" {
  type        = string
  description = "Type of domain to be created. Default value is full for regular domains. To create a partial domain for CNAME setup, set this variable to partial."
  default     = "full"
  validation {
    condition     = contains(["full", "partial"], var.domain_type)
    error_message = "Provided value of domain_type is not alllowed."
  }
}
