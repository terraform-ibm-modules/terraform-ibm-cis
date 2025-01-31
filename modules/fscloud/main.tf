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

/*
A 30-second sleep time has been added as a workround to ensure that the Cloud Interface Services (CIS) instance and domain are fully configured
before making changes to the domain settings to enable Web Application Firewall (WAF) for the instance. Failing to include this
sleep time can result in the following error:

  │ Error: Not allowed to edit setting for waf
  │
  │   with module.cis_domain_settings.ibm_cis_domain_settings.domain_settings,
  │   on ../../modules/waf/main.tf line 5, in resource "ibm_cis_domain_settings" "domain_settings":
  │    5: resource "ibm_cis_domain_settings" "domain_settings" {
  │
  ╵}
The issue is being tracked here: https://github.com/IBM-Cloud/terraform-provider-ibm/issues/5118
*/

resource "time_sleep" "wait_for_cis_instance" {
  depends_on = [module.cis_instance]

  create_duration = "30s"
}

module "cis_domain_settings" {
  source           = "../../modules/waf"
  depends_on       = [time_sleep.wait_for_cis_instance]
  cis_instance_id  = module.cis_instance.cis_instance_id
  domain_id        = module.cis_instance.cis_domain.domain_id
  enabled_rulesets = var.enabled_rulesets
}
##############################################################################
