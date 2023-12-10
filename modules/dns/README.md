# CIS DNS module

This module is used to create and manage IBM Cloud Internet Services (CIS) DNS records.


Although the SRV record name is provided in the variable, it is stored as `_service._proto.record_name.domain_name TTL class type of record priority weight port target`. For more information, see  [What is a DNS SRV record?](https://www.cloudflare.com/en-gb/learning/dns/dns-records/dns-srv-record/).


The changed name means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the DNS record requires an update, as shown in the following example. You can ignore that message. Your infrastructure will not be affected.


    # module.cis_dns_records[0].ibm_cis_dns_record.dns_records["NAME/SRV"] will be updated in-place
    ~ resource "ibm_cis_dns_record" "dns_records" {
        id          = "a5177ec049fc2973a33df1441e869a27:9684838a87ecxxx5518:crn:v1:bluemix:public:internet-svcs:global:a/abac0df06b644axxx4f55b3880e:6ee7ec9a-5e68-4b6f-af9a-5714xxx4d::"
        ~ name      = "_sip._udp.test-example.srv.test**.**.com" -> "test-example.srv"
        # (13 unchanged attributes hidden)
        }

If you add a CAA record, a `flags` parameter is returned in the data object. The work is being tracked in `IBM-Cloud/terraform-provider-ibm` [issue 4792](https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4792).

The returned `flags` parameter means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the DNS record requires an update, as shown in the following example. You can ignore that message. Your infrastructure will not be affected.


    # module.cis_dns_records.ibm_cis_dns_record.dns_records["test-exmple.caa/CAA"] will be updated in-place
    ~ resource "ibm_cis_dns_record" "dns_records" {
        ~ data        = {
            - "flags" = "0" -> null
                # (2 unchanged elements hidden)
            }
            id        = "fcef7410xxxxxxbad23c5fd0e7581b7c:7e66xxxxxecc7e12ac908ca75445ad21:crn:v1:bluemix:public:internet-svcs:global:a/abac0df06b644axxxxx6e44f55b3880e:06240432-xxxx-40e7-9f9c-594dfbdfe208::"
            # (12 unchanged attributes hidden)
        }

The DNS records can be imported from a file in IBM Cloud Internet Services. This module allows the import of DNS records in two ways:

* using the local file path (if accessible)
* using the base64 encoded string for the file

To convert the records text file to base64 encoded string:
```sh
cat dns_records.txt | base64
```

If you successfully import DNS records using the base64 encoded string method, and then run a `terraform plan` command, you will receive a message stating that the `ibm_cis_dns_records_import` resource and the `local_file` resource need to be forcefully replaced as shown below. This happens because the `local_file` resource block generates a unique filename everytime and therefore needs to be updated. However, if you do `terraform apply` then the DNS records will not get duplicated and infrastructure remains the same.

    # module.cis_dns_records.ibm_cis_dns_records_import.import_dns_records[0] must be replaced
    -/+ resource "ibm_cis_dns_records_import" "import_dns_records" {
      ~ file                 = "../../modules/dns/dns_records_2023-12-10T09" # forces replacement -> (known after apply) #
      ~ records_added        = 3 -> (known after apply)
      ~ total_records_parsed = 3 -> (known after apply)
    }
    # module.cis_dns_records.local_file.dns_record_file[0] must be replaced
    -/+ resource "local_file" "dns_record_file" {
      ~ filename             = "../../modules/dns/dns_records_2023-12-10T09:29:24Z.txt"-> (known after apply) # forces replacement
      ~ id                   = "de87dcxxxxfec671eexxxxxxxxx30accaxxxxa13" -> (known after apply)
        # (3 unchanged attributes hidden)
    }
        Plan: 2 to add, 0 to change, 2 to destroy.


It also shows changes to output as below. You can ignore that message. Your infrastructure will not be affected.

    Changes to Outputs:
    ~ cis_dns_records     = {
        ~ cis_imported_dns_records = [
            ~ {
                ~ file                 = "../../modules/dns/dns_records_2023-12-10T09:45:59Z.txt" -> (known after apply)
                ~ id                   = "3:3:../../modules/dns/dns_records_2023-12-10T09:45:59Z.txt:e47cxxxxx7caf0xxxxx452395xxxxxfe:crn:v1:bluemix:public:internet-svcs:global:a/abxxxxx06xxxxa9cxxxxx44f5xxxxx0e:exxx8xx5-7xx1-4xx1-bxxe-2xxxxa2xxxxf::" -> (known after apply)
                + records_added        = (known after apply)
                + total_records_parsed = (known after apply)
                },
            ]
    }




<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, <1.6.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |
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
