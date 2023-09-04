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
  tags              = []
  plan              = "trial"
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
  dns_record_set = [
    {
      type    = "A"
      name    = "test-example"
      content = "1.2.3.4"
      ttl     = 900
    }
  ]
}

##############################################################################
# Add global load balancer to CIS instance
##############################################################################

module "cis_glb" {
  source             = "../../modules/glb"
  cis_instance_id    = module.cis_instance.cis_instance_id
  domain_id          = module.cis_domain.cis_domain.domain_id
  glb_name           = join(".", [var.glb_name, var.domain_name])
  fallback_pool_name = "glb1"
  glb_description    = "Load Balancer"
  glb_enabled        = true
  ttl                = 120

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
