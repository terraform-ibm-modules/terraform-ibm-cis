
output "dns_record_ids" {
  value       = module.cis_domain.dns_record_ids
  description = "List of DNS record IDs"
}

output "origin_pool_ids" {
  value       = module.cis_glb.origin_pool_ids
  description = "List of origin pool IDs"
}
