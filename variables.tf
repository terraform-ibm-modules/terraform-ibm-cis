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
  description = "Add user resource tags to the Cis instance to organize, track, and manage costs. [Learn more](https://cloud.ibm.com/docs/account?topic=account-tag&interface=ui#tag-types)."
  default     = []
  validation {
    condition     = alltrue([for tag in var.tags : can(regex("^[A-Za-z0-9 _\\-.:](1, 128)$", tag))])
    error_message = "Each resource tag must be 128 characters or less and may contain only A-Z, a-z, 0-9, spaces, underscore (_), hyphen (-), period (.), and colon (:)."
  }
}

variable "domain_name" {
  type        = string
  description = "The domain name to be added to the CIS instance."
}
##############################################################################
