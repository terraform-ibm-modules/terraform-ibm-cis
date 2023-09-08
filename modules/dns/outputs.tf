
output "cis_dns_records" {
  description = "DNS records of CIS instance"
  value       = ibm_cis_dns_record.dns_records
}
