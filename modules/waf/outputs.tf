output "cis_waf_rulesets" {
  description = "WAF rulesets of CIS instance"
  value       = var.enable_waf ? ibm_cis_ruleset_entrypoint_version.waf_config[0].rulesets : null
}
