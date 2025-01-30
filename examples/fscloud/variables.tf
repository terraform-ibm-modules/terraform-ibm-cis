##############################################################################
# Input variables
##############################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key."
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example."
  default     = "fscloud-cis"
}

variable "resource_group" {
  type        = string
  description = "The name of an existing resource group to provision resources to. If not set, a new resource group is created that uses the prefix variable"
  default     = null
}

variable "domain_name" {
  type        = string
  description = "Domain name to be added for the CIS Instance."
  default     = "example.cloud.ibm.com"
}

variable "enable_cis_managed_ruleset" {
  type        = bool
  description = "To control whether to enable CIS Managed Ruleset"
  default     = true
}

variable "enable_cis_exposed_creds_check_ruleset" {
  type        = bool
  description = "To control whether to enable CIS Exposed Credentials Check Ruleset"
  default     = true
}

variable "enable_cis_owasp_core_ruleset" {
  type        = bool
  description = "To control whether to enable CIS Owasp Core Ruleset"
  default     = true
}

variable "enabled_rulesets" {
  description = "Map to control which rulesets are enabled"
  type        = map(bool)
  default = {
    "CIS Managed Ruleset"                 = true,
    "CIS Exposed Credentials Check Ruleset" = false,
    "CIS OWASP Core Ruleset"              = true
  }
}