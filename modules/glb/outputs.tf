output "glb_id" {
  description = "Id of CIS GLB"
  value       = ibm_cis_global_load_balancer.cis_glb.id
}
output "cis_glb" {
  description = "Details of CIS GLB"
  value       = ibm_cis_global_load_balancer.cis_glb
}


output "origin_pool_ids" {
  description = "Ids of CIS origin pools"
  value       = [for pool in ibm_cis_origin_pool.origin_pool : pool.id]
}
output "cis_pools" {
  description = "Details of CIS origin pools"
  value       = ibm_cis_origin_pool.origin_pool
}


output "health_check_id" {
  description = "Id of CIS Health Check"
  value       = [for monitor in ibm_cis_healthcheck.health_check : monitor.id]
}
output "cis_health_check" {
  description = "Details of CIS Health Check"
  value       = ibm_cis_healthcheck.health_check
}