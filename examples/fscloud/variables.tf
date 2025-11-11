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

variable "enable_waf_rulesets" {
  description = "List of rulesets to be enabled for web application firewal(WAF). For more information, refer to the [IBM Cloud Managed Rules Overview](https://cloud.ibm.com/docs/cis?topic=cis-managed-rules-overview)."
  type        = list(string)
  default     = ["CIS Managed Ruleset", "Exposed Credentials Check", "OWASP Core Ruleset"]
}
