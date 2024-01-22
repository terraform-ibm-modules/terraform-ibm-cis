##############################################################################
# Create Cloud Internet Services (CIS) service
##############################################################################

resource "ibm_cis" "cis_instance" {
  name              = var.service_name
  plan              = var.plan
  resource_group_id = var.resource_group_id
  tags              = var.tags
  location          = "global"

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

##############################################################################
# Add domain to CIS instance
##############################################################################

module "cis_domain" {
  source          = "./modules/domain"
  domain_name     = var.domain_name
  cis_instance_id = ibm_cis.cis_instance.id
}

##############################################################################
