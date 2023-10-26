
variable "cis_instance_id" {
  type        = string
  description = "CRN of the existing CIS instance."
}

variable "domain_id" {
  type        = string
  description = "ID of the existing domain to add a DNS record to the CIS instance."
}

variable "waf" {
    type = string
    description = "Enable a web application firewall (WAF). Supported values are off and on."
}

variable "ssl" {
  type = string
  description = "Allowed values: off, flexible, full, strict, origin_pull"
}

variable "min_tls_version" {
  type = string
  description = "The minimum TLS version that you want to allow. Allowed values are 1.1, 1.2, or 1.3. "
}