##############################################################################
# Add domain
##############################################################################

resource "ibm_cis_domain" "cis_domain" {
  domain = var.domain_name
  cis_id = var.cis_instance_id
  type   = var.domain_type
}

resource "null_resource" "delay_30s" {
  provisioner "local-exec" {
    command = "echo 'Resource is provisioned, waiting for 2 minutes'"
  }

  triggers = {
    instance_id = ibm_cis_domain.cis_domain
  }
}
