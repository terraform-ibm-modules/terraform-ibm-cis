
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
  description = "Enable a web application firewall (WAF). Supported values are off and on."
  validation {
    condition     = contains(["on", "off"], var.waf)
    error_message = "Provided value of waf is not alllowed."
  }
}

variable "ssl" {
  type        = string
  description = "Allowed values: off, flexible, full, strict, origin_pull."
  validation {
    condition     = contains(["off", "flexible", "full", "strict", "origin_pull"], var.ssl)
    error_message = "Provided value of ssl is not alllowed."
  }
}

variable "min_tls_version" {
  type        = string
  description = "The minimum TLS version that you want to allow. Allowed values are 1.1, 1.2, or 1.3."
  validation {
    condition     = contains(["1.1", "1.2", "1.3"], var.min_tls_version)
    error_message = "Provided value of tls version is not alllowed."
  }
}
