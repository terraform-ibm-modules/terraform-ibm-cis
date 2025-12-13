##############################################################################
# Resource group
##############################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Create CIS instance and add domain
##############################################################################
module "cis_instance" {
  source              = "../../modules/fscloud"
  service_name        = "${var.prefix}-example"
  resource_group_id   = module.resource_group.resource_group_id
  enable_waf_rulesets = var.enable_waf_rulesets
  tags                = []
  plan                = "standard-next"
  domain_name         = var.domain_name
  add_dns_records     = true
  dns_record_set = [
    {
      type    = "A"
      name    = "test-example"
      content = "1.2.3.4"
      proxied = true
    }
  ]
  add_glb = false
}
