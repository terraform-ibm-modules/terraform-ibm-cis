
output "cis_dns_records" {
  description = "DNS records of CIS instance"
  value       = ibm_cis_dns_record.dns_records
}

output "cis_imported_dns_records" {
  description = "Imported DNS records from a file."
  value       = ibm_cis_dns_records_import.dns_record
}
