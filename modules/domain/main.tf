resource "ibm_cis" "cis_instance" {
  count             = var.is_cis_instance_exist == false ? 1 : 0
  name              = var.service_name
  plan              = var.plan
  resource_group_id = var.resource_group_id
  tags              = (var.tags != null ? var.tags : null)
  location          = "global"
}
data "ibm_cis" "cis_instance" {
  name       = var.service_name
  depends_on = [ibm_cis.cis_instance]
}
resource "ibm_cis_domain" "cis_domain" {
  count  = var.is_cis_domain_exist == false ? 1 : 0
  domain = var.domain
  cis_id = data.ibm_cis.cis_instance.id
}
data "ibm_cis_domain" "cis_domain" {
  domain     = var.domain
  cis_id     = data.ibm_cis.cis_instance.id
  depends_on = [ibm_cis_domain.cis_domain]
}

resource "ibm_cis_dns_record" "dns_rescords" {
  cis_id    = data.ibm_cis.cis_instance.id
  domain_id = data.ibm_cis_domain.cis_domain.domain_id
  for_each  = { for record in var.record_set : join("/", [lookup(record, "name", ""), record.type]) => record }
  name      = lookup(each.value, "name", "")
  type      = each.value.type
  content   = lookup(each.value, "content", null)
  data      = lookup(each.value, "data", null)
  ttl       = lookup(each.value, "ttl", null)
  priority  = lookup(each.value, "priority", null)
  proxied   = lookup(each.value, "proxied", null)
}