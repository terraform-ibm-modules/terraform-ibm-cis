
output "domain_id" {
  value       = module.cis_domain.domain_id
  description = "Domain ID"
}

output "origin_pool_ids" {
  value       = module.cis_glb.origin_pool_ids
  description = "List of origin pools"
}
output "glb_id" {
  value       = module.cis_glb.glb_id
  description = "Global Load Balancer ID"
}
