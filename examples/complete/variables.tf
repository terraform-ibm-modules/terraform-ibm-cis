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
  description = "The name of an existing resource group to provision resources to. If not set, a new resource group is created that uses the prefix variable"
  default     = null
}

variable "domain_name" {
  type        = string
  description = "Domain name to be added for the CIS Instance."
  default     = "example.cloud.ibm.com"
}

variable "glb_name" {
  description = "Name of the CIS global load balancer."
  type        = string
  default     = "glb"
}
