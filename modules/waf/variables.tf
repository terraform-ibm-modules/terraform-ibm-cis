
variable "cis_instance_id" {
  type        = string
  description = "CRN of the existing CIS instance."
}

variable "domain_id" {
  type        = string
  description = "ID of the existing domain to add a DNS record to the CIS instance."
}

variable "waf" {
  type        = string
  description = "Enable/disable a web application firewall (WAF). Supported values are off and on."
  validation {
    condition     = contains(["on", "off"], var.waf)
    error_message = "Provided value of waf is not allowed. Supported values are off and on."
  }
}
