module "cis-domain" {
  source                = "../../modules/domain"
  is_cis_instance_exist = var.is_cis_instance_exist
  service_name          = var.service_name
  is_cis_domain_exist   = var.is_cis_domain_exist
  domain                = var.domain
  plan                  = var.plan
}
module "cis-glb" {
  source             = "../../modules/glb"
  cis_id             = module.cis-domain.cis_id
  domain_id          = module.cis-domain.domain_id
  glb_name           = join(".", [var.glb_name, var.domain])
  fallback_pool_name = local.origin_pools[0].name
  glb_description    = "Load balancer"
  glb_proxied        = var.glb_proxied
  session_affinity   = "cookie"
  origin_pools       = local.origin_pools
}
