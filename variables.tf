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
    condition     = contains(["standard-next", "trial", "enterprise-usage"], var.plan)
    error_message = "Only the trial, standard-next and enterprise-usage plans are supported currently"
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
##############################################################################
