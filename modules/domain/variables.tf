
variable "cis_instance_id" {
  type        = string
  description = "GUID of CIS instance"
}

variable "domain" {
  type        = string
  description = "Domain name of CIS Instance"
}

variable "domain_type" {
  type        = string
  description = "The type of domain to be created. Default value is full for regular domains. To create a partial domain for CNAME setup, set this variable to partial."
  default     = "full"
  validation {
    condition     = contains(["full", "partial"], var.domain_type)
    error_message = "Only full and partial values are allowed for type of domain"
  }
}
