
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
}
