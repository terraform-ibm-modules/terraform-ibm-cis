
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
  description = "Enables/disables a web application firewall (WAF). Supported values are off and on."
  validation {
    condition     = contains(["on", "off"], var.waf)
    error_message = "Provided value of waf is not allowed. Supported values are off and on."
  }
}

variable "min_tls_version" {
  type        = string
  description = "The minimum TLS version that you want to allow. Allowed values are 1.1, 1.2, or 1.3"
  validation {
    condition     = contains(["1.1", "1.2", "1.3"], var.min_tls_version)
    error_message = "Provided value of min_tls_version is not allowed. Supported values are '1.1', '1.2', or '1.3'."
  }
}
