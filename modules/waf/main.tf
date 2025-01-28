##############################################################################
# To enable/disable Web Application Firewall(WAF) for a domain
##############################################################################

locals {

  rulesets_list                                  = data.ibm_cis_rulesets.rulesets.rulesets_list
  rulesets_map                                   = { for rule in local.rulesets_list : rule.name => rule.ruleset_id }
  ruleset_id_for_cis_managed_ruleset             = local.rulesets_map["CIS Managed Ruleset"]
  ruleset_id_for_cis_owasp_core_ruleset          = local.rulesets_map["CIS OWASP Core Ruleset"]
  ruleset_id_for_cis_exposed_creds_check_ruleset = local.rulesets_map["CIS Exposed Credentials Check Ruleset"]
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
    rules {
      action = "execute"
      action_parameters {
        id = local.ruleset_id_for_cis_managed_ruleset
      }
      enabled    = var.enable_cis_managed_ruleset
      expression = "true"
    }
    rules {
      action = "execute"
      action_parameters {
        id = local.ruleset_id_for_cis_exposed_creds_check_ruleset
      }
      enabled    = var.enable_cis_exposed_creds_check_ruleset
      expression = "true"
    }
    rules {
      action = "execute"
      action_parameters {
        id = local.ruleset_id_for_cis_owasp_core_ruleset
      }
      enabled    = var.enable_cis_owasp_core_ruleset
      expression = "true"
    }
  }
}
