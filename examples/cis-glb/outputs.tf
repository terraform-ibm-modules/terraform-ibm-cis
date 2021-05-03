
output "domain_id" {
  value = module.cis-domain.domain_id
}

output "origin_pool_ids" {
  value = module.cis-glb.origin_pool_ids
}
output "glb_id" {
  value = module.cis-glb.glb_id
}