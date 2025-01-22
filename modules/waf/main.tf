##############################################################################
# To enable/disable Web Application Firewall(WAF) for a domain
##############################################################################


resource "ibm_cis_ruleset_entrypoint_version" "config" {
    cis_id    = var.cis_instance_id
    domain_id = var.domain_id
    phase = "http_request_firewall_managed"
    rulesets {
      description = "Entry Point ruleset"
      rules {
        action =  "execute"
        action_parameters  {
          id = "efb7b8c949ac4650a09736fc376e9aee"
          }
        enabled = true 
        expression = "true"
      }
      rules {
        action =  "execute"
        action_parameters  {
          id = "c2e184081120413c86c3ab7e14069605"
          }
        enabled = true 
        expression = "true"
      }
      rules {
        action =  "execute"
        action_parameters  {
          id = "4814384a9e5d4991b9815dcfc25d2f1f"
          }
        enabled = true 
        expression = "true"
      }
    }
  }