##############################################################################
# To enable/disable Web Application Firewall(WAF) for a domain
##############################################################################

resource "ibm_cis_domain_settings" "domain_settings" {
  cis_id          = var.cis_instance_id
  domain_id       = var.domain_id
  waf             = var.enable_waf ? "on" : "off"
  min_tls_version = "1.2" #Temporary fix - The min_tls_version default value (1.2) gets modified to 1.1 while applying domain_settings. This will be reverted back once the provider issue(IBM-Cloud/terraform-provider-ibm#4937) is fixed.
}
