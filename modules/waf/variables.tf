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
  description = "Set to true to enable/disable the legacy WAF. To enable WAF by using managed rulesets, please use variable 'enable_waf_rulesets'. For more information, refer [this](https://cloud.ibm.com/docs/cis?topic=cis-migrating-to-managed-rules)"
  default     = false
}

variable "enable_waf_rulesets" {
  description = "List of rulesets to be enabled for web application firewal(WAF). For more information, refer to the [IBM Cloud Managed Rules Overview](https://cloud.ibm.com/docs/cis?topic=cis-managed-rules-overview)."
  type        = list(string)
  default     = ["CIS Managed Ruleset", "CIS Exposed Credentials Check Ruleset", "CIS OWASP Core Ruleset"]

  validation {
    condition     = alltrue([for rule in var.enable_waf_rulesets : contains(keys(local.rulesets_map), rule)])
    error_message = "The following ruleset names are invalid: ${join(", ", [for rule in var.enable_waf_rulesets : rule if !contains(keys(local.rulesets_map), rule)])}"
  }
}

variable "rulesets_description" {
  description = "Description of the rulesets to be enabled."
  type        = string
  default     = "Managed rulesets"
}
