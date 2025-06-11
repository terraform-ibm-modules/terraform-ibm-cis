# CIS DNS module

This module is used to create and manage IBM Cloud Internet Services (CIS) DNS records. For more information, see the [main readme file](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/docs/README.md) for this module.

### Usage

```
provider "ibm" {
  ibmcloud_api_key = ""
}

module "cis_dns_records" {
  source          = "terraform-ibm-modules/cis/ibm/dns"
  cis_instance_id = "crn:v1:bluemix:public:internet-svcs:global:a/xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX:xxxxxxxx-XXXX-xxxx-XXXX-xxxxxXXXXxxxx::"
  domain_id       = "xxxxXXXXxxxxXXXXxxxxxxxxXXXXxxxx"
  dns_record_set  = [
    {
      type    = "A"
      name    = "test-example"
      content = "1.2.3.4"
      ttl     = 900
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.79.0, < 2.0.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.4.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cis_dns_record.dns_records](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_dns_record) | resource |
| [ibm_cis_dns_records_import.import_dns_records](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_dns_records_import) | resource |
| [local_file.dns_record_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base64_encoded_dns_records_file"></a> [base64\_encoded\_dns\_records\_file](#input\_base64\_encoded\_dns\_records\_file) | The base64-encoded DNS zone file in BIND format that contains the details of the DNS records [Learn more](https://cloud.ibm.com/docs/dns-svcs?topic=dns-svcs-managing-dns-records&interface=ui). Required if `dns_records_file` is not specified. | `string` | `null` | no |
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of the existing CIS instance. | `string` | n/a | yes |
| <a name="input_dns_record_set"></a> [dns\_record\_set](#input\_dns\_record\_set) | List of DNS records to be added for the CIS Instance. | <pre>list(object({<br>    name     = string<br>    type     = string<br>    ttl      = optional(number) # in unit seconds, starts with value 120<br>    content  = optional(string)<br>    priority = optional(number) # mandatory for SRV type of record<br>    proxied  = optional(bool)   # default value is false<br>    data = optional(object({<br>      altitude       = optional(number) # mandatory for LOC type of record<br>      lat_degrees    = optional(number) # mandatory for LOC type of record<br>      lat_direction  = optional(string) # mandatory for LOC type of record<br>      lat_minutes    = optional(number) # mandatory for LOC type of record<br>      lat_seconds    = optional(number) # mandatory for LOC type of record<br>      long_degrees   = optional(number) # mandatory for LOC type of record<br>      long_direction = optional(string) # mandatory for LOC type of record<br>      long_minutes   = optional(number) # mandatory for LOC type of record<br>      long_seconds   = optional(number) # mandatory for LOC type of record<br>      precision_horz = optional(number) # mandatory for LOC type of record<br>      precision_vert = optional(number) # mandatory for LOC type of record<br>      size           = optional(number) # mandatory for LOC type of record<br>      tag            = optional(string) # required for CAA type of record<br>      value          = optional(string) # required for CAA type of record<br>      target         = optional(string) # required for SRV type of record<br>      priority       = optional(number) # required for SRV type of record<br>      port           = optional(number) # mandatory for SRV type of record<br>      proto          = optional(string) # mandatory for SRV type of record<br>      service        = optional(string) # mandatory for SRV type of record, starts with an '_'<br>      weight         = optional(number) # mandatory for SRV type of record<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_dns_records_file"></a> [dns\_records\_file](#input\_dns\_records\_file) | The DNS file in text format that contains the details of the DNS records. Required if `base64_encoded_dns_records_file` is not specified. | `string` | `null` | no |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | ID of the existing domain to add a DNS record to the CIS instance. | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_dns_records"></a> [cis\_dns\_records](#output\_cis\_dns\_records) | DNS records of CIS instance |
| <a name="output_cis_imported_dns_records"></a> [cis\_imported\_dns\_records](#output\_cis\_imported\_dns\_records) | Imported DNS records from a file. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
