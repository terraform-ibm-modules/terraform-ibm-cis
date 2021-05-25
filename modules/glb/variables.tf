
variable "cis_id" {
  description = "CRN of CIS Service Instance"
  type        = string
}
variable "domain_id" {
  description = "Domain ID of CIS Service Instance"
  type        = string
}

// GLB Variables
variable "glb_name" {
  description = "Name of CIS Global Load Balancer"
  type        = string
}
variable "fallback_pool_id" {
  description = "FallBack Pool Id. Conflicts with fallback_pool_name"
  type        = string
  default     = null
}
variable "default_pool_ids" {
  description = "Default Pool Ids."
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
  description = "Proxy of CIS Global Load Balancer"
  type        = bool
  default     = null
}
variable "session_affinity" {
  description = "Session Affinity of CIS Global Load Balancer"
  type        = string
  default     = null
}
variable "glb_enabled" {
  description = "Enable / Disable of CIS Global Load Balancer"
  type        = bool
  default     = null
}
variable "ttl" {
  description = "TTL of CIS Global Load Balancer"
  type        = number
  default     = null
}
variable "region_pools" {
  description = "Region Pools of CIS Global Load Balancer"
  default     = []
}
variable "pop_pools" {
  description = "Pop Pools of CIS Global Load Balancer"
  default     = []
}

// Pool Variables
variable "origin_pools" {
  description = "List of objects of origin pools"
}
//Health Check Variables
variable "monitors" {
  description = "List of monitors to be created"
  default     = []
}