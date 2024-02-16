##############################################################################
# Resource group
##############################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.4"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Create CIS instance and add domain
##############################################################################
module "cis_instance" {
  source            = "../../modules/fscloud"
  service_name      = "${var.prefix}-example"
  resource_group_id = module.resource_group.resource_group_id
  tags              = []
  plan              = "standard-next"
  domain_name       = var.domain_name
  add_dns_records   = true
  dns_record_set = [
    {
      type    = "A"
      name    = "test-example"
      content = "1.2.3.4"
      ttl     = 900
      proxied = true
    }
  ]
  add_glb            = true
  glb_name           = join(".", [var.glb_name, var.domain_name])
  fallback_pool_name = "glb1"
  glb_description    = "Load Balancer"
  glb_enabled        = true

  origin_pools = [
    {
      name = "glb1"
      origins = [{
        name    = "o-1"
        address = "1.1.1.0"
        enabled = true
        },
        {
          name    = "o-2"
          address = "1.1.1.4"
          enabled = true
      }]
      enabled           = true
      description       = "Test GLB"
      check_regions     = ["WEU"]
      health_check_name = "hc1"
    }
  ]

  health_checks = [
    {
      expected_body  = "alive"
      expected_codes = "200"
      method         = "GET"
      timeout        = 7
      path           = "/health"
      interval       = 60
      retries        = 3
      name           = "hc1"
    }
  ]
}
