##############################################################################
# Resource group
##############################################################################

module "resource_group" {
  count   = var.is_cis_instance_exists ? 0 : 1
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.0.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# CIS instance
##############################################################################

module "cis_instance" {
  count             = var.is_cis_instance_exists ? 0 : 1
  source            = "../../"
  service_name      = "${var.prefix}-cis"
  resource_group_id = module.resource_group[0].resource_group_id
  tags              = var.resource_tags
  plan              = var.plan
}

##############################################################################
# Add domain to CIS instance
##############################################################################

module "cis_domain" {
  count           = var.is_add_domain ? 1 : 0
  source          = "../../modules/cis-domain-module"
  domain_name     = var.domain_name
  cis_instance_id = var.is_cis_instance_exists ? var.cis_instance_id : module.cis_instance[0].cis_instance_id
}

##############################################################################
# Add dns records to CIS instance
##############################################################################

module "cis_dns_records" {
  count           = var.is_add_dns_records ? 1 : 0
  source          = "../../modules/cis-dns-module"
  cis_instance_id = var.is_cis_instance_exists ? var.cis_instance_id : module.cis_instance[0].cis_instance_id
  domain_id       = var.is_add_domain ? module.cis_domain[0].cis_domain.domain_id : var.existing_domain_id
  dns_record_set  = var.dns_record_set
}

##############################################################################
# Add global load balancer to CIS instance
##############################################################################

module "cis_glb" {
  count              = var.is_add_glb ? 1 : 0
  source             = "../../modules/cis-glb-module"
  cis_instance_id    = var.is_cis_instance_exists ? var.cis_instance_id : module.cis_instance[0].cis_instance_id
  domain_id          = var.is_add_domain ? module.cis_domain[0].cis_domain.domain_id : var.existing_domain_id
  glb_name           = var.domain_name != null ? join(".", [var.glb_name, var.domain_name]) : join(".", [var.glb_name, var.existing_domain_name])
  fallback_pool_name = var.origin_pools[0].name
  glb_description    = var.glb_description
  glb_enabled        = var.glb_enabled
  glb_proxied        = var.glb_proxied
  session_affinity   = var.session_affinity
  origin_pools       = var.origin_pools
  health_checks      = var.health_checks
}
