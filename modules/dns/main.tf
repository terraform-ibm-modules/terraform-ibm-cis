##############################################################################
# Add DNS records
##############################################################################

locals {
  # tflint-ignore: terraform_unused_declarations
  validate_inputs = [for record in var.dns_record_set : (record.type == "SRV" || record.type == "LOC" || record.type == "CAA") ? (record.data != null ? null : tobool("The data{} block in dns_record_set is not defined for the DNS record -  ${record.name}")) : null]
}

resource "ibm_cis_dns_record" "dns_records" {
  cis_id    = var.cis_instance_id
  domain_id = var.domain_id
  for_each  = { for record in var.dns_record_set : join("/", [lookup(record, "name", ""), record.type]) => record }
  name      = lookup(each.value, "name", "")
  type      = each.value.type
  content   = lookup(each.value, "content", null)
  ttl       = lookup(each.value, "ttl", null)
  priority  = lookup(each.value, "priority", null)
  data      = ((each.value.data != null) && (each.value.type == "SRV")) ? merge(each.value.data, { "name" : lookup(each.value, "name", "") }) : lookup(each.value, "data", null)
  proxied   = lookup(each.value, "proxied", false)
}
