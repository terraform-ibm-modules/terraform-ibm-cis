
variable "cis_instance_id" {
  type        = string
  description = "CRN of the existing CIS instance."
}

variable "domain_id" {
  type        = string
  description = "ID of the existing domain to add a DNS record to the CIS instance."
}


variable "enable_cis_managed_ruleset" {
  type        = bool
  description = "To control whether to enable CIS Managed Ruleset"
  default     = false
}

variable "enable_cis_exposed_creds_check_ruleset" {
  type        = bool
  description = "To control whether to enable CIS Exposed Credentials Check Ruleset"
  default     = false
}

variable "enable_cis_owasp_core_ruleset" {
  type        = bool
  description = "To control whether to enable CIS Owasp Core Ruleset"
  default     = false
}
