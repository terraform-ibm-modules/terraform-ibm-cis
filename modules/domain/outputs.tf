output "cis_id" {
  description = "CRN of CIS Service Instance"
  value       = data.ibm_cis.cis_instance.id
}
output "domain_id" {
  description = "ID id CIS Domain"
  value       = data.ibm_cis_domain.cis_domain.domain_id
}
output "ibm_cis" {
  description = "Details of CIS Service Instance"
  value       = data.ibm_cis.cis_instance
}
output "ibm_domain" {
  description = "Details id CIS Domain"
  value       = data.ibm_cis_domain.cis_domain
}
output "dns_record_ids" {
  description = "Ids CIS DNS Records"
  value       = [for record in ibm_cis_dns_record.dns_rescords : record.id]
}

output "dns_records" {
  description = "Details of CIS DNS Records"
  value       = ibm_cis_dns_record.dns_rescords
}