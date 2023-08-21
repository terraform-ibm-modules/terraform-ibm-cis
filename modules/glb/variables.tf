
variable "cis_instance_id" {
  description = "CRN of CIS Service Instance."
  type        = string
}

variable "domain_id" {
  description = "Domain ID of CIS Service Instance."
  type        = string
}

# GLB Variables
variable "glb_name" {
  description = "The DNS name to associate with CIS Global Load Balancer. It can be a hostname."
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
}

variable "glb_description" {
  description = "Description of CIS Global Load Balancer."
  type        = string
  default     = null
}

variable "glb_proxied" {
  description = "Set to true if the host name receives origin protection by IBM CIS. Default value is false."
  type        = bool
  default     = true
}

variable "session_affinity" {
  description = "Session Affinity of CIS Global Load Balancer."
  type        = string
  default     = null
}

variable "glb_enabled" {
  description = "To enable/disable CIS Global Load Balancer. If set to true, the load balancer is enabled and can receive network traffic."
  type        = bool
}

variable "steering_policy" {
  description = "Steering Policy of CIS Global Load Balancer."
  type        = string
  default     = "off"
  validation {
    condition     = contains(["off", "geo", "random", "dynamic_latency"], var.steering_policy)
    error_message = "Provided value of steering_policy is not allowed"
  }
}

variable "ttl" {
  description = "Time-to-live(TTL) in seconds of CIS Global Load Balancer(GLB). Allowed value is 120 or greater if GLB is not proxied otherwise it is automatically set."
  type        = number
  default     = null
}

variable "region_pools" {
  description = "Region Pools of CIS Global Load Balancer."
  type = list(object({
    region   = string
    pool_ids = list(string)
  }))
  default = []
}

variable "pop_pools" {
  description = "Pop Pools of CIS Global Load Balancer."
  type = list(object({
    pop      = string
    pool_ids = list(string)
  }))
  default = []
}

# Pool Variables
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
  default = []
}

# Health Check Variables
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
    headers = optional(list(object({
      header = optional(string)
      values = optional(string)
    })))
  }))
  default = []
}
