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
  default     = "example-cis"
}

variable "resource_group" {
  type        = string
  description = "The name of an existing resource group to provision resources in to. If not set a new resource group will be created using the prefix variable"
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources."
  default     = []
}

variable "plan" {
  type        = string
  description = "Plan for the CIS instance. standard-next or trial."
  default     = "trial"
}

variable "is_cis_instance_exists" {
  type        = bool
  description = "Set to true if CIS instance exists already."
  default     = false
}

variable "cis_instance_id" {
  type        = string
  description = "CRN of CIS instance. Required if variable is_cis_instance_exists set to true."
  default     = null
}

variable "is_add_domain" {
  type        = bool
  description = "Set to true if need to add domain in CIS instance."
  default     = true
}

variable "existing_domain_id" {
  type        = string
  description = "Domain ID of CIS instance if exists already. Required if variable add_domain set to false."
  default     = null
}

variable "existing_domain_name" {
  type        = string
  description = "Domain name of CIS instance if exists already. Required if variable add_domain set to false."
  default     = null
}

variable "is_add_dns_records" {
  type        = bool
  description = "Set to true if need to add DNS records in CIS instance."
  default     = true
}

variable "is_add_glb" {
  type        = bool
  description = "Set to true if need to add GLB feature in CIS instance."
  default     = true
}

variable "domain_name" {
  type        = string
  description = "Domain name to be added for CIS Instance."
  default     = "example.com"
}

variable "record_set" {
  description = "List of DNS records to be added for CIS Instance."
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
      name    = "test-example"
      content = "1.2.3.4"
      ttl     = 900
    }
  ]
}

variable "glb_name" {
  description = "Name of CIS Global Load Balancer."
  type        = string
  default     = "glb"
}

variable "glb_description" {
  description = "Description of CIS Global Load Balancer."
  type        = string
  default     = "Load Balancer"
}

variable "glb_enabled" {
  description = "To enable/disable CIS Global Load Balancer. If set to true, the load balancer is enabled and can receive network traffic."
  type        = bool
  default     = true
}

variable "glb_proxied" {
  description = "Set to true if the host name receives origin protection by IBM CIS. Default value is false."
  type        = bool
  default     = true
}

variable "session_affinity" {
  description = "Session Affinity of CIS Global Load Balancer. To make use of session affinity, glb_proxied has to be true."
  type        = string
  default     = "cookie"
}

variable "origin_pools" {
  description = "List of origins with an associated health check to be created for CIS Global Load Balancer."
  type = list(object({
    name = string
    origins = list(object({
      name    = string
      address = string
      enabled = optional(bool)
      weight  = optional(number)
    }))
    enabled            = bool # if set to true, the pool is enabled and can receive incoming network traffic
    description        = optional(string)
    check_regions      = list(string) # list of region codes
    minimum_origins    = optional(number)
    health_check_name  = optional(string)
    notification_email = optional(string)
  }))
  default = [
    {
      name = "glb1"
      origins = [{
        name    = "o-1"
        address = "1.1.1.0"
        enabled = true
        },
        {
          name    = "o-2"
          address = "1.1.1.4"
          enabled = true
      }]
      enabled           = true
      description       = "Test GLB"
      check_regions     = ["WEU"]
      health_check_name = "hc1"
    }
  ]
}

variable "health_checks" {
  description = "List of health checks to be created for CIS Global Load Balancer."
  type = list(object({
    name             = string
    description      = optional(string)
    path             = optional(string)
    type             = optional(string)
    port             = optional(number)
    expected_body    = string
    expected_codes   = string
    method           = optional(string)
    timeout          = optional(number)
    follow_redirects = optional(bool)
    allow_insecure   = optional(bool)
    interval         = optional(number)
    retries          = optional(number)
  }))
  default = [
    {
      expected_body  = "alive"
      expected_codes = "200"
      method         = "GET"
      timeout        = 7
      path           = "/health"
      interval       = 60
      retries        = 3
      name           = "hc1"
    }
  ]
}