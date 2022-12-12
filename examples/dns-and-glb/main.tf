module "cis-domain" {
  source                = "../../modules/domain"
  is_cis_instance_exist = var.is_cis_instance_exist
  service_name          = var.service_name
  is_cis_domain_exist   = var.is_cis_domain_exist
  domain                = var.domain
  record_set            = local.record_set
  plan                  = var.plan
}

module "cis-glb" {
  source             = "../../modules/glb"
  cis_id             = module.cis-domain.cis_id
  domain_id          = module.cis-domain.domain_id
  glb_name           = var.glb_name
  fallback_pool_name = var.fallback_pool_name
  region_pools       = local.region_pools
  origin_pools       = local.origin_pools
  monitors           = local.monitors
  steering_policy    = var.steering_policy
}
