output "glb_id" {
  description = "Id of CIS GLB"
  value       = ibm_cis_global_load_balancer.cis_glb.id
}

output "origin_pool_ids" {
  description = "Ids of CIS origin pools"
  value       = [for pool in ibm_cis_origin_pool.origin_pool : pool.id]
}

output "health_check_id" {
  description = "Id of CIS Health Check"
  value       = [for monitor in ibm_cis_healthcheck.health_check : monitor.id]
}
