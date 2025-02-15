##############################################################################
# To enable/disable Web Application Firewall(WAF) for a domain
##############################################################################

locals {
  rulesets_list = data.ibm_cis_rulesets.rulesets.rulesets_list
  rulesets_map  = { for rule in local.rulesets_list : rule.name => rule.ruleset_id }

  # Filter and construct the rules array
  rules = [
    for rule in var.enabled_rulesets : contains(keys(local.rulesets_map), rule) ? {
      id         = local.rulesets_map[rule]
      enabled    = true
      expression = "true"
    } : null
  ]
}

resource "ibm_cis_domain_settings" "domain_settings" {

  count     = var.use_legacy_waf ? 1 : 0
  cis_id    = var.cis_instance_id
  domain_id = var.domain_id
  waf       = var.enable_waf ? "on" : "off"
}

moved {
  from = ibm_cis_domain_settings.domain_settings
  to   = ibm_cis_domain_settings.domain_settings[0]
}

data "ibm_cis_rulesets" "rulesets" {
  cis_id    = var.cis_instance_id
  domain_id = var.domain_id
}

resource "ibm_cis_ruleset_entrypoint_version" "config" {

  count = var.enable_waf ? 1 : 0

  cis_id    = var.cis_instance_id
  domain_id = var.domain_id
  phase     = "http_request_firewall_managed"

  rulesets {
    description = var.description

    dynamic "rules" {
      for_each = [for rule in local.rules : rule if rule != null]
      content {
        action = "execute"
        action_parameters {
          id = rules.value.id
        }
        enabled    = rules.value.enabled
        expression = rules.value.expression
      }
    }
  }
}
