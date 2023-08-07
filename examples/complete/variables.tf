##############################################################################
# Input variables
##############################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example"
  default     = "example-cis"
}

variable "resource_group" {
  type        = string
  description = "The name of an existing resource group to provision resources in to. If not set a new resource group will be created using the prefix variable"
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
}

variable "plan" {
  type        = string
  description = "Plan for the CIS instance. Standard-next or free."
  default     = "trial"
}

variable "domain" {
  type        = string
  description = "Domain name of CIS Instance"
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
  default = [
    {
      type    = "A"
      name    = "test-example1"
      content = "1.2.3.4"
      ttl     = 900
    }
  ]
}
