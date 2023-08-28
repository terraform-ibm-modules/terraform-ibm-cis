output "glb_id" {
  description = "ID of CIS GLB"
  value       = ibm_cis_global_load_balancer.cis_glb.id
}

output "origin_pool_ids" {
  description = "IDs of CIS origin pools"
  value       = [for pool in ibm_cis_origin_pool.origin_pool : pool.id]
}

output "health_check_id" {
  description = "IDs of CIS Health Checks"
  value       = [for monitor in ibm_cis_healthcheck.health_check : monitor.id]
}
