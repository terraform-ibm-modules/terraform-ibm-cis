
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

