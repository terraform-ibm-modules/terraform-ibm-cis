##############################################################################
# Create CIS instance and add domain
##############################################################################

module "cis_instance" {
  source            = "../../"
  service_name      = var.service_name
  resource_group_id = var.resource_group_id
  tags              = var.tags
  plan              = var.plan
  domain_name       = var.domain_name
}

##############################################################################
# Add dns records to CIS instance
##############################################################################
locals {
  # tflint-ignore: terraform_unused_declarations
  validate_dns_input = (var.add_dns_records && length(var.dns_record_set) == 0) ? tobool("No DNS records found.") : true
  # tflint-ignore: terraform_unused_declarations
  validate_dns_records = [for record in var.dns_record_set : tobool("DNS records must be proxied for enabling DDoS protection.") if record.proxied != true]
  # tflint-ignore: terraform_unused_declarations
  validate_glb_input = var.add_glb ? ((var.fallback_pool_name == null && var.fallback_pool_id == null) ? tobool("Both fallback_pool_name and fallback_pool_id can not be null.") : true) : true
}

module "cis_dns_records" {
  count           = var.add_dns_records ? 1 : 0
  source          = "../../modules/dns"
  cis_instance_id = module.cis_instance.cis_instance_id
  domain_id       = module.cis_instance.cis_domain.domain_id
  dns_record_set  = var.dns_record_set
}

##############################################################################
# Add global load balancer to CIS instance
##############################################################################

module "cis_glb" {
  count              = var.add_glb ? 1 : 0
  source             = "../../modules/glb"
  cis_instance_id    = module.cis_instance.cis_instance_id
  domain_id          = module.cis_instance.cis_domain.domain_id
  glb_name           = var.glb_name
  fallback_pool_name = var.fallback_pool_name
  fallback_pool_id   = var.fallback_pool_id
  default_pool_ids   = var.default_pool_ids
  glb_description    = var.glb_description
  glb_enabled        = var.glb_enabled
  ttl                = null
  glb_proxied        = true
  session_affinity   = var.session_affinity
  steering_policy    = var.steering_policy
  region_pools       = var.region_pools
  pop_pools          = var.pop_pools
  origin_pools       = var.origin_pools
  health_checks      = var.health_checks
}

##############################################################################
# Enables web application firewall(WAF) to CIS instance
##############################################################################

module "cis_domain_settings" {
  source          = "../../modules/waf"
  cis_instance_id = module.cis_instance.cis_instance_id
  domain_id       = module.cis_instance.cis_domain.domain_id
  enable_waf      = true
}
##############################################################################
