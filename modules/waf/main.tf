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

data "ibm_cis_rulesets" "rulesets" {
  cis_id    = var.cis_instance_id
  domain_id = var.domain_id
}

resource "ibm_cis_ruleset_entrypoint_version" "config" {
  cis_id    = var.cis_instance_id
  domain_id = var.domain_id
  phase     = "http_request_firewall_managed"

  rulesets {
    description = "Entry Point ruleset"

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
