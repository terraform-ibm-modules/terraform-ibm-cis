
variable "cis_instance_id" {
  type        = string
  description = "CRN of the existing CIS instance."
}

variable "domain_id" {
  type        = string
  description = "ID of the existing domain to add a DNS record to the CIS instance."
}

variable "enabled_rulesets" {
  description = "List of rulesets and whether they are enabled or not"
  type        = list(string)
  default     = ["CIS Managed Ruleset", "CIS Exposed Credentials Check Ruleset", "CIS OWASP Core Ruleset"]

  validation {

    condition     = alltrue([for rule in var.enabled_rulesets : contains(keys(local.rulesets_map), rule)])
    error_message = "The following rule names are invalid: ${join(", ", [for rule in var.enabled_rulesets : rule if !contains(keys(local.rulesets_map), rule)])}"
  }

}
