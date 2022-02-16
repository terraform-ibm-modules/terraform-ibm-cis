resource "ibm_cis" "cis_instance" {
  count             = var.is_cis_instance_exist == false ? 1 : 0
  name              = var.service_name
  plan              = var.plan
  resource_group_id = var.resource_group_id
  tags              = (var.tags != null ? var.tags : null)
  location          = "global"
}
data "ibm_cis" "cis_instance" {
  count             = var.is_cis_instance_exist == false ? 0 : 1
  name              = var.service_name
  resource_group_id = var.resource_group_id
}
locals {
  cis_id    = var.is_cis_instance_exist == false ? ibm_cis.cis_instance[0].id : data.ibm_cis.cis_instance[0].id
  domain_id = var.is_cis_domain_exist == false ? ibm_cis_domain.cis_domain[0].domain_id : data.ibm_cis_domain.cis_domain[0].domain_id
}
resource "ibm_cis_domain" "cis_domain" {
  count  = var.is_cis_domain_exist == false ? 1 : 0
  domain = var.domain
  cis_id = local.cis_id
}
data "ibm_cis_domain" "cis_domain" {
  count  = var.is_cis_domain_exist == false ? 0 : 1
  domain = var.domain
  cis_id = local.cis_id
}

resource "ibm_cis_dns_record" "dns_rescords" {
  cis_id    = local.cis_id
  domain_id = local.domain_id
  for_each  = { for record in var.record_set : join("/", [lookup(record, "name", ""), record.type]) => record }
  name      = lookup(each.value, "name", "")
  type      = each.value.type
  content   = lookup(each.value, "content", null)
  data      = lookup(each.value, "data", null)
  ttl       = lookup(each.value, "ttl", null)
  priority  = lookup(each.value, "priority", null)
  proxied   = lookup(each.value, "proxied", null)
}