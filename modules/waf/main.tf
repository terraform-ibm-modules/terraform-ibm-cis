##############################################################################
# Enable Web Application Firewall for a domain
##############################################################################

resource "ibm_cis_domain_settings" "domain_settings" {
  cis_id          = var.cis_instance_id
  domain_id       = var.domain_id
  waf             = var.waf
  ssl             = var.ssl
  min_tls_version = var.min_tls_version
}
