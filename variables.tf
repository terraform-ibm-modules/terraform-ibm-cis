##############################################################################
# List of input varaibles - example
##############################################################################

variable "resource_group_id" {
  type        = string
  description = "Resource group ID where CIS instance will be created."
}

variable "service_name" {
  type        = string
  description = "Name of the CIS instance."
}

variable "plan" {
  type        = string
  description = "Plan for the CIS instance. Standard-next or trial."
  default     = "trial"
  validation {
    condition     = contains(["standard-next", "trial"], var.plan)
    error_message = "Only the trial and standard-next plan is supported currently"
  }
}

variable "tags" {
  type        = list(string)
  description = "List of tags to be associated to CIS instance."
  default     = []
}
##############################################################################
