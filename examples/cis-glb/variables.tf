
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
  default     = "sub.cis-terraform.com"
}
variable "glb_name" {
  description = "Name of CIS Global Load Balancer"
  type        = string
  default     = "glb"
}
variable "pool_name" {
  description = "Name of CIS Origin Pool"
  type        = string
  default     = "pool"
}
variable "origin_server" {
  description = "Name of CIS Origin server"
  type        = string
  default     = "os"
}
variable "server_address" {
  description = "Name of CIS Origin Pool"
  type        = list(string)
  default     = ["1.1.1.1", "1.1.1.2", "1.1.1.3"]
}
