##############################################################################
# Add DNS records
##############################################################################

locals {
  # tflint-ignore: terraform_unused_declarations
  validate_dns_record_data = [for record in var.dns_record_set : (record.type == "SRV" || record.type == "LOC" || record.type == "CAA") ? (record.data != null ? null : tobool("The data{} block in dns_record_set is not defined for the DNS record- ${record.name}")) : null]
  # tflint-ignore: terraform_unused_declarations
  validate_dns_record_content = [for record in var.dns_record_set : ((record.content == null && record.data != null) || (record.content != null && record.data == null)) ? null : tobool("Both the content and data can not be defined within the dns_record_set for the DNS record - ${record.name}")]
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

resource "ibm_cis_dns_records_import" "dns_record_import" {
  count     = var.dns_records_file != null ? 1 : 0
  cis_id    = var.cis_instance_id
  domain_id = var.domain_id
  file      = var.dns_records_file
}
