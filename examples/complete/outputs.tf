##############################################################################
# Outputs
##############################################################################

output "cis_instance_details" {
  description = "CIS instance details"
  value       = module.cis_instance
}

output "cis_domain_details" {
  description = "CIS Domain details"
  value       = module.cis_domain
}
