
variable "cis_instance_id" {
  type        = string
  description = "CRN of the existing CIS instance."
}

variable "domain_id" {
  type        = string
  description = "ID of the existing domain to add a DNS record to the CIS instance."
}

variable "dns_record_set" {
  description = "List of DNS records to be added for the CIS Instance."
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
      for record in var.dns_record_set : contains(["A", "AAAA", "CNAME", "NS", "MX", "TXT", "LOC", "SRV", "CAA", "PTR"], record.type)
    ])
    error_message = "The specified DNS record type is not valid."
  }
}

variable "base64_encoded_dns_records_file" {
  type        = string
  description = "The base64-encoded DNS zone file in BIND format that contains the details of the DNS records [Learn more](https://cloud.ibm.com/docs/dns-svcs?topic=dns-svcs-managing-dns-records&interface=ui). Required if `dns_records_file` is not specified."
  default     = null
}

variable "dns_records_file" {
  type        = string
  description = "The DNS file in text format that contains the details of the DNS records. Required if `base64_encoded_dns_records_file` is not specified."
  default     = null
}
