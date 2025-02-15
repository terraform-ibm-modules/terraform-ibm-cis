variable "cis_instance_id" {
  type        = string
  description = "CRN of the existing CIS instance."
}

variable "domain_id" {
  type        = string
  description = "ID of the existing domain to add a DNS record to the CIS instance."
}

variable "enable_waf" {
  type        = bool
  description = "To control whether the web application firewall (WAF) is enabled or disabled for a CIS instance."
  default     = true
}

variable "use_legacy_waf" {
  type        = bool
  description = "Set to true to enable/disable the old way of enabling WAF. To enable WAF by using managed rulesets, please use variable 'enabled_rulesets'. For more information, refer [this](https://cloud.ibm.com/docs/cis?topic=cis-migrating-to-managed-rules)"
  default     = false
}

variable "enabled_rulesets" {
  description = "List of rulesets to be enabled. For more information, refer to the [IBM Cloud Managed Rules Overview](https://cloud.ibm.com/docs/cis?topic=cis-managed-rules-overview)."
  type        = list(string)
  default     = ["CIS Managed Ruleset", "CIS Exposed Credentials Check Ruleset", "CIS OWASP Core Ruleset"]

  validation {
    condition     = alltrue([for rule in var.enabled_rulesets : contains(keys(local.rulesets_map), rule)])
    error_message = "The following rule names are invalid: ${join(", ", [for rule in var.enabled_rulesets : rule if !contains(keys(local.rulesets_map), rule)])}"
  }
}
