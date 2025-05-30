##############################################################################
# Add DNS records
##############################################################################

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

##############################################################################
# Import DNS records from a file
##############################################################################

resource "local_file" "dns_record_file" {
  count          = var.base64_encoded_dns_records_file != null ? 1 : 0
  content_base64 = var.base64_encoded_dns_records_file
  filename       = "${path.module}/dns_records_${timestamp()}.txt"
}

resource "ibm_cis_dns_records_import" "import_dns_records" {
  count      = ((var.base64_encoded_dns_records_file == null && var.dns_records_file == null) || (var.base64_encoded_dns_records_file != null && var.dns_records_file != null)) ? 0 : 1
  depends_on = [local_file.dns_record_file]
  cis_id     = var.cis_instance_id
  domain_id  = var.domain_id
  file       = var.base64_encoded_dns_records_file != null ? local_file.dns_record_file[0].filename : var.dns_records_file
}
