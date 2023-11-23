##############################################################################
# To enable/disable Web Application Firewall(WAF) for a domain
##############################################################################

resource "ibm_cis_domain_settings" "domain_settings" {
  cis_id          = var.cis_instance_id
  domain_id       = var.domain_id
  waf             = var.waf
  min_tls_version = "1.2" # The min_tls_version default value was getting modified to 1.1 while terraform apply. Provider issue is open here: https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4937
}
