##############################################################################
# Add domain
##############################################################################

resource "ibm_cis_domain" "cis_domain" {
  domain = var.domain_name
  cis_id = var.cis_instance_id
  type   = var.domain_type
}

resource "time_sleep" "wait_for_cis_instance" {
  depends_on = [ibm_cis_domain.cis_domain]

  create_duration = "30s"
}

# This resource will create (at least) 30 seconds after null_resource.previous
resource "null_resource" "next" {
  depends_on = [time_sleep.wait_for_cis_instance]
}

# resource "null_resource" "delay_30s" {
#   provisioner "local-exec" {
#     command = "echo 'Resource is provisioned, waiting for 30 seconds'"
#   }

#   triggers = {
#     instance_id = ibm_cis_domain.cis_domain.id
#   }
# }
