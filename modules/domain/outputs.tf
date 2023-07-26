# output "cis_id" {
#   description = "CRN of CIS Service Instance"
#   value       = local.cis_id
# }
# output "domain_id" {
#   description = "ID id CIS Domain"
#   value       = local.domain_id
# }
# output "dns_record_ids" {
#   description = "Ids CIS DNS Records"
#   value       = [for record in ibm_cis_dns_record.dns_rescords : record.id]
# }

output "cis_domain" {
  description = "CIS Domain details"
  value       = ibm_cis_domain.cis_domain
}
