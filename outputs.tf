##############################################################################
# Outputs
##############################################################################

output "cis_instance_name" {
  description = "CIS instance name"
  value       = ibm_cis.cis_instance.name
}

output "cis_instance_guid" {
  description = "GUID of CIS instance"
  value       = ibm_cis.cis_instance.guid
}

output "cis_instance_id" {
  description = "CRN of CIS instance"
  value       = ibm_cis.cis_instance.id
}

output "cis_instance_status" {
  description = "Status of CIS instance"
  value       = ibm_cis.cis_instance.status
}

output "cis_domain" {
  description = "CIS Domain details"
  value       = module.cis_domain.cis_domain_details
}
##############################################################################
