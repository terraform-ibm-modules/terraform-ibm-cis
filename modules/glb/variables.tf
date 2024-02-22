
variable "cis_instance_id" {
  description = "CRN of the existing CIS Instance."
  type        = string
}

variable "domain_id" {
  description = "Existing domain ID of the CIS Instance."
  type        = string
}

# GLB Variables
variable "glb_name" {
  description = "The DNS name to associate with CIS global load balancer. It can be a hostname."
  type        = string
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

variable "glb_proxied" {
  description = "Set to true if the host name receives origin protection by IBM CIS instance."
  type        = bool
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

variable "ttl" {
  description = "Time to live (TTL) for the CIS global load balancer (GLB), in seconds. If the GLB is proxied, the value is set automatically."
  type        = number
  default     = null
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
