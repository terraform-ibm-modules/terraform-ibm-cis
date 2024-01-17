##############################################################################
# Add domain
##############################################################################

resource "ibm_cis_domain" "cis_domain" {
  domain = var.domain_name
  cis_id = var.cis_instance_id
  type   = var.domain_type
}

resource "time_sleep" "wait_for_domain" {
  depends_on = [ibm_cis_domain.cis_domain]

  create_duration = "60s"
}
