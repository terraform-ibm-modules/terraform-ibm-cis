
variable "cis_instance_id" {
  type        = string
  description = "CRN of the existing CIS instance."
}

variable "domain_id" {
  type        = string
  description = "ID of the existing domain to add a DNS record."
}

variable "dns_record_set" {
  description = "List of DNS records to be created."
  type = list(object({
    name     = string
    type     = string
    ttl      = optional(number) # in unit seconds, starts with value 120
    content  = optional(string)
    priority = optional(number) # mandatory for SRV type of record
    proxied  = optional(bool)   # default value is false
    data = optional(object({
      altitude       = optional(number) # mandatory for LOC type of record
      lat_degrees    = optional(number) # mandatory for LOC type of record
      lat_direction  = optional(string) # mandatory for LOC type of record
      lat_minutes    = optional(number) # mandatory for LOC type of record
      lat_seconds    = optional(number) # mandatory for LOC type of record
      long_degrees   = optional(number) # mandatory for LOC type of record
      long_direction = optional(string) # mandatory for LOC type of record
      long_minutes   = optional(number) # mandatory for LOC type of record
      long_seconds   = optional(number) # mandatory for LOC type of record
      precision_horz = optional(number) # mandatory for LOC type of record
      precision_vert = optional(number) # mandatory for LOC type of record
      size           = optional(number) # mandatory for LOC type of record
      tag            = optional(string) # required for CAA type of record
      value          = optional(string) # required for CAA type of record
      target         = optional(string) # required for SRV type of record
      priority       = optional(number) # required for SRV type of record
      port           = optional(number) # mandatory for SRV type of record
      proto          = optional(string) # mandatory for SRV type of record
      service        = optional(string) # mandatory for SRV type of record, starts with an '_'
      weight         = optional(number) # mandatory for SRV type of record
    }))
  }))
  default = []
  validation {
    condition = alltrue([
      for record in var.dns_record_set : contains(["A", "AAAA", "CNAME", "NS", "MX", "TXT", "LOC", "SRV", "CAA", "SPF", "PTR"], record.type)
    ])
    error_message = "The specified DNS record type is not valid."
  }
}
