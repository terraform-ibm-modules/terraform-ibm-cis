
output "dns_record_ids" {
  value = module.cis-domain.dns_record_ids
}

output "origin_pool_ids" {
  value = module.cis-glb.origin_pool_ids
}
