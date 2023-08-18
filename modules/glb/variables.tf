
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
  description = "Name of CIS Global Load Balancer."
  type        = string
}

variable "fallback_pool_id" {
  description = "FallBack Pool ID. Conflicts with fallback_pool_name"
  type        = string
  default     = null
}

variable "default_pool_ids" {
  description = "Default Pool IDs."
  type        = list(string)
  default     = null
}

variable "fallback_pool_name" {
  description = "FallBack Pool Name. Conflicts with fallback_pool_id"
  type        = string
}

variable "glb_description" {
  description = "Description of CIS Global Load Balancer"
  type        = string
  default     = null
}

variable "glb_proxied" {
  description = "Proxy of CIS Global Load Balancer. Default value if false."
  type        = bool
  default     = false
}

variable "session_affinity" {
  description = "Session Affinity of CIS Global Load Balancer"
  type        = string
  default     = null
}

variable "glb_enabled" {
  description = "To enable / disable CIS Global Load Balancer. If set to true, the load balancer is enabled and can receive network traffic."
  type        = bool
}

variable "steering_policy" {
  description = "Steering Policy of CIS Global Load Balancer"
  type        = string
  default     = "off"
  validation {
    condition     = contains(["off", "geo", "random", "dynamic_latency"], var.steering_policy)
    error_message = "Provided value of steering_policy is not allowed"
  }
}

variable "ttl" {
  description = "time-to-live(TTL) of CIS Global Load Balancer in seconds. Allowed value is 120 or greater if GLB is not in proxy."
  type        = number
  default     = null
}

variable "region_pools" {
  description = "Region Pools of CIS Global Load Balancer"
  type = list(object({
    region   = string
    pool_ids = list(string)
  }))
  default = []
}

variable "pop_pools" {
  description = "Pop Pools of CIS Global Load Balancer"
  type = list(object({
    pop      = string
    pool_ids = list(string)
  }))
  default = []
}

# Pool Variables
variable "origin_pools" {
  description = "List of objects of origin pools"
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
    monitor_name       = optional(string)
    notification_email = optional(string)
  }))
  default = []
}

# Health Check Variables
variable "monitors" {
  description = "List of monitors to be created"
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
      values = optional(string) #Note Header is not currently supported in this version of the provider.
    })))
  }))
  default = []
}
