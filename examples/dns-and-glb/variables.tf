
variable "region" {
  description = "IBMCloud region"
  type        = string
  default     = "us-south"
}
variable "service_name" {
  type        = string
  description = "Name of the CIS instance that has to be created"
  default     = "CISTest"
}
variable "is_cis_instance_exist" {
  type        = bool
  description = "Make this as true to read existing CIS instance"
  default     = false
}

variable "is_cis_domain_exist" {
  type        = bool
  description = "Make this as true to read existing CIS domain"
  default     = false
}

variable "steering_policy" {
  description = "Steering Policy"
  type        = string
  default     = "off"
}

variable "plan" {
  type        = string
  description = "Plan of the CIS instance that has to be created"
  default     = "standard-next"
}

variable "domain" {
  type        = string
  description = "Domain Name that has to be created on CIS Instance"
  default     = "cis-terraform.com"
}
variable "glb_name" {
  description = "Name of CIS Global Load Balancer"
  type        = string
  default     = "test.cis-terraform.com"
}
variable "fallback_pool_name" {
  description = "FallBack Pool Name. Conflicts with fallback_pool_id"
  type        = string
  default     = "op1"
}
