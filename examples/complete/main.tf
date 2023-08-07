##############################################################################
# Resource group
##############################################################################

module "resource_group" {
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
  domain          = var.domain
  cis_instance_id = module.cis_instance.cis_instance_id
}

##############################################################################
# Add dns records to CIS instance
##############################################################################

# locals {
#   dummy_value = { for rec in var.record_set : join("/", [lookup(rec, "name", ""), rec.type]) => rec }
# }

module "cis_dns_records" {
  source          = "../../modules/dns"
  cis_instance_id = module.cis_instance.cis_instance_id
  domain_id       = module.cis_domain.cis_domain.domain_id
  record_set      = var.record_set
}
