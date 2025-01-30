
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
  type = list(object({
    rule_name = string
    enabled   = bool
  }))
  default = [
    { rule_name = "CIS Managed Ruleset",                   enabled = true },
    { rule_name = "CIS Exposed Credentials Check Ruleset", enabled = true },
    { rule_name = "CIS OWASP Core Ruleset",                enabled = true }
  ]
}

