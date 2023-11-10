
output "cis_dns_records" {
  description = "DNS records of CIS instance"
  value       = ibm_cis_dns_record.dns_records
}

output "cis_dns_records_import" {
  description = "DNS records imported through a file"
  value       = ibm_cis_dns_records_import.dns_record_import
}
