##############################################################################
# Outputs
##############################################################################

output "cis_instance" {
  description = "CIS instance details"
  value       = module.cis_instance
}

output "cis_domain" {
  description = "CIS Domain details"
  value       = module.cis_domain
}

output "cis_dns_records" {
  description = "CIS DNS records"
  value       = module.cis_dns_records
}
