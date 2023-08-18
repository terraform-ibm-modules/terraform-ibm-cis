##############################################################################
# Add domain
##############################################################################

resource "ibm_cis_domain" "cis_domain" {
  domain = var.domain
  cis_id = var.cis_instance_id
  type   = var.domain_type
}
