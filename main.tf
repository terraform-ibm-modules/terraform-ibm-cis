##############################################################################
# List of modules or resources
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
