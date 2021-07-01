module "cis-domain" {
  source                = "../../modules/domain"
  is_cis_instance_exist = true
  service_name          = var.service_name
  is_cis_domain_exist   = false
  domain                = var.domain
}
module "cis-glb" {
  source             = "../../modules/glb"
  cis_id             = module.cis-domain.cis_id
  domain_id          = module.cis-domain.domain_id
  glb_name           = join(".", [var.glb_name, var.domain])
  fallback_pool_name = local.origin_pools[0].name
  glb_description    = "Load balancer"
  glb_proxied        = true
  session_affinity   = "cookie"
  origin_pools       = local.origin_pools
}
