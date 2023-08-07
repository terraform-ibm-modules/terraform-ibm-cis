
variable "cis_instance_id" {
  type        = string
  description = "ID of CIS instance"
}

variable "domain_id" {
  type        = string
  description = "Domain ID of CIS Instance"
}

variable "record_set" {
  description = "Create DNS records of CIS Instance"
  type = list(object({
    name     = optional(string)
    type     = string
    ttl      = optional(number)
    content  = optional(string)
    priority = optional(number)
    data = optional(object({
      altitude       = optional(number)
      lat_degrees    = optional(number)
      lat_direction  = optional(string)
      lat_minutes    = optional(number)
      lat_seconds    = optional(number)
      long_degrees   = optional(number)
      long_direction = optional(string)
      long_minutes   = optional(number)
      long_seconds   = optional(number)
      precision_horz = optional(number)
      precision_vert = optional(number)
      size           = optional(number)
      tag            = optional(string)
      value          = optional(string)
      port           = optional(number)
      priority       = optional(number)
      proto          = optional(string)
      service        = optional(string)
      target         = optional(string)
      weight         = optional(number)
      name           = optional(string)
    }))
  }))
  default = []
}
