##############################################################################
# List of input varaibles
##############################################################################

variable "resource_group_id" {
  type        = string
  description = "The resource group ID to provision the CIS instance."
}

variable "service_name" {
  type        = string
  description = "Name of the CIS instance."
}

variable "plan" {
  type        = string
  description = "The type of plan for the CIS instance: standard-next or trial."
  default     = "trial"
  validation {
    condition     = contains(["standard-next", "trial"], var.plan)
    error_message = "Only the trial and standard-next plans are supported currently"
  }
}

variable "tags" {
  type        = list(string)
  description = "List of tags to be associated to the CIS instance."
  default     = []
}

variable "domain_name" {
  type        = string
  description = "The domain name to be added to the CIS instance."
}

# DNS variables
variable "add_dns_records" {
  description = "Set to true if dns records to be added to the CIS instance"
  type        = bool
  default     = false
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

# GLB variables
variable "add_glb" {
  description = "Set to true if global load balancer(glb) to be added to the CIS instance"
  type        = bool
  default     = false
}

variable "glb_name" {
  description = "The DNS name to associate with CIS global load balancer. It can be a hostname."
  type        = string
  default     = null
}

variable "fallback_pool_id" {
  description = "ID of the fallback pool. Required if fallback_pool_name is not provided."
  type        = string
  default     = null
}

variable "default_pool_ids" {
  description = "List of default pool IDs."
  type        = list(string)
  default     = null
}

variable "fallback_pool_name" {
  description = "FallBack Pool Name. Required if fallback_pool_id is not provided."
  type        = string
  default     = null
}

variable "glb_description" {
  description = "Description of the CIS global load balancer."
  type        = string
  default     = null
}

variable "session_affinity" {
  description = "Session Affinity of the CIS global load balancer. To make use of session affinity, glb_proxied has to be true."
  type        = string
  default     = null
}

variable "glb_enabled" {
  description = "Whether the CIS global load balancer is enabled. If set to true, the load balancer is enabled and can receive network traffic."
  type        = bool
  default     = null
}

variable "steering_policy" {
  description = "Steering Policy of the CIS global load balancer."
  type        = string
  default     = "off"
  validation {
    condition     = contains(["off", "geo", "random", "dynamic_latency"], var.steering_policy)
    error_message = "Provided value of steering_policy is not allowed"
  }
}

variable "region_pools" {
  description = "Region pools of the CIS global load balancer."
  type = list(object({
    region   = string
    pool_ids = list(string)
  }))
  default = []
}

variable "pop_pools" {
  description = "Pop pools of the CIS global load balancer."
  type = list(object({
    pop      = string
    pool_ids = list(string)
  }))
  default = []
}

# Pool Variables
variable "origin_pools" {
  description = "List of origins with an associated health check to be created for the CIS global load balancer."
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
  default = []
}

# Health Check Variables
variable "health_checks" {
  description = "List of health checks to be created for the CIS global load balancer."
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
  default = []
}

variable "enabled_rulesets" {
  description = "List of rulesets and whether they are enabled or not. For more information, refer to the [IBM Cloud Managed Rules Overview](https://cloud.ibm.com/docs/cis?topic=cis-managed-rules-overview)."
  type        = list(string)
  default     = ["CIS Managed Ruleset", "CIS Exposed Credentials Check Ruleset", "CIS OWASP Core Ruleset"]
}
