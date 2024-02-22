##############################################################################
# Outputs
##############################################################################

output "cis_instance_name" {
  description = "CIS instance name"
  value       = module.cis_instance.cis_instance_name
}

output "cis_instance_guid" {
  description = "GUID of CIS instance"
  value       = module.cis_instance.cis_instance_guid
}

output "cis_instance_id" {
  description = "CRN of CIS instance"
  value       = module.cis_instance.cis_instance_id
}

output "cis_instance_status" {
  description = "Status of CIS instance"
  value       = module.cis_instance.cis_instance_status
}

output "cis_domain" {
  description = "CIS Domain details"
  value       = module.cis_instance.cis_domain
}

output "cis_glb_id" {
  description = "ID of CIS GLB"
  value       = var.add_glb == true ? module.cis_glb[0] : null
}

output "cis_dns_records" {
  description = "DNS records of CIS instance"
  value       = var.add_dns_records == true ? module.cis_dns_records[0].cis_dns_records : null
}
##############################################################################
