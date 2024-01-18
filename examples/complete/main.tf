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
  source            = "../../"
  service_name      = "${var.prefix}-cis"
  resource_group_id = module.resource_group.resource_group_id
  tags              = []
  plan              = "standard-next"
  domain_name       = var.domain_name
}

##############################################################################
# Add dns records to CIS instance
##############################################################################

# module "cis_dns_records" {
#   source          = "../../modules/dns"
#   cis_instance_id = module.cis_instance.cis_instance_id
#   domain_id       = module.cis_instance.cis_domain.domain_id
#   dns_record_set = [
#     {
#       type    = "A"
#       name    = "test-example"
#       content = "1.2.3.4"
#       ttl     = 900
#     }
#   ]
#   dns_records_file = "dns_records.txt"
# }

##############################################################################
# Add global load balancer to CIS instance
##############################################################################

# module "cis_glb" {
#   source             = "../../modules/glb"
#   cis_instance_id    = module.cis_instance.cis_instance_id
#   domain_id          = module.cis_instance.cis_domain.domain_id
#   glb_name           = join(".", [var.glb_name, var.domain_name])
#   fallback_pool_name = "glb1"
#   glb_description    = "Load Balancer"
#   glb_enabled        = true
#   ttl                = 120

#   origin_pools = [
#     {
#       name = "glb1"
#       origins = [{
#         name    = "o-1"
#         address = "1.1.1.0"
#         enabled = true
#         },
#         {
#           name    = "o-2"
#           address = "1.1.1.4"
#           enabled = true
#       }]
#       enabled           = true
#       description       = "Test GLB"
#       check_regions     = ["WEU"]
#       health_check_name = "hc1"
#     }
#   ]

#   health_checks = [
#     {
#       expected_body  = "alive"
#       expected_codes = "200"
#       method         = "GET"
#       timeout        = 7
#       path           = "/health"
#       interval       = 60
#       retries        = 3
#       name           = "hc1"
#     }
#   ]
# }

##############################################################################
# Enables web application firewall(WAF) to CIS instance
##############################################################################

# resource "time_sleep" "wait_for_cis_instance" {
#   depends_on = [module.cis_instance]

#   create_duration = "120s"
# }

# # This resource will create (at least) 30 seconds after null_resource.previous
# resource "null_resource" "next" {
#   depends_on = [time_sleep.wait_for_cis_instance]
# }
# cis domain settings
module "cis_domain_settings" {
  source = "../../modules/waf"
  # depends_on      = [null_resource.next]
  cis_instance_id = module.cis_instance.cis_instance_id
  domain_id       = module.cis_instance.cis_domain.domain_id
  enable_waf      = true
}
