##############################################################################
# Resource group
##############################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.0.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# CIS instance
##############################################################################

module "cis_instance" {
  source            = "../../"
  service_name      = "${var.prefix}-cis"
  resource_group_id = module.resource_group.resource_group_id
  tags              = var.resource_tags
  plan              = var.plan
}

##############################################################################
# Add domain to CIS instance
##############################################################################

module "cis_domain" {
  source          = "../../modules/domain"
  domain_name     = var.domain_name
  cis_instance_id = module.cis_instance.cis_instance_id
}

##############################################################################
# Add dns records to CIS instance
##############################################################################

module "cis_dns_records" {
  source          = "../../modules/dns"
  cis_instance_id = module.cis_instance.cis_instance_id
  domain_id       = module.cis_domain.cis_domain.domain_id
  dns_record_set  = var.dns_record_set
}

##############################################################################
# Add global load balancer to CIS instance
##############################################################################

module "cis_glb" {
  source             = "../../modules/glb"
  cis_instance_id    = module.cis_instance.cis_instance_id
  domain_id          = module.cis_domain.cis_domain.domain_id
  glb_name           = join(".", [var.glb_name, var.domain_name])
  fallback_pool_name = var.origin_pools[0].name
  glb_description    = var.glb_description
  glb_enabled        = var.glb_enabled
  ttl                = var.ttl
  origin_pools       = var.origin_pools
  health_checks      = var.health_checks
}
