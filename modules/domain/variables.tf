variable "is_cis_instance_exist" {
  type        = bool
  description = "Determines if cis instance exits or not. If set true it will not create a cis instance"
  default     = null
}
variable "service_name" {
  type        = string
  description = "Name of the CIS instance."
}
variable "plan" {
  type        = string
  description = "Plan of the CIS instance that has to be created"
  default     = null
}
variable "resource_group_id" {
  type        = string
  description = "Resource group ID in which CIS instance that has to be created"
  default     = null
}
variable "tags" {
  type        = list(string)
  description = "Tags attached to CIS Instance"
  default     = null
}
variable "is_cis_domain_exist" {
  type        = bool
  description = "Determines if cis domains exits or not. If set true it will not create a cis domain"
  default     = null
}
variable "domain" {
  type        = string
  description = "Domain name of CIS Instance"
}

variable "record_set" {
  description = "Set objects of CIS Service Instance DNS Records that has to be created"
  default     = []
}