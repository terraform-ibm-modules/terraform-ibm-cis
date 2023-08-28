# Module CIS DNS

This module is used to create and manage CIS DNS Records.

**Note:**
1. For SRV record, you need to provide record name two times as shown in the below example.

    ```
    {
        type = "SRV"
        ttl  = 900
        name = "test-example.srv"
        data = {
            name     = "test-example.srv"
            port     = 1
            priority = 1
            proto    = "_udp"
            service  = "_sip"
            target   = "domain.com"
            weight   = 1
        }
        }
    ```

2. Though SRV record name is provided in the variable but it gets stored as `_service._proto.record_name.domain_name TTL class type of record priority weight port target` For more information, refer this [link](https://www.cloudflare.com/en-gb/learning/dns/dns-records/dns-srv-record/). Because of this, if you run `terraform plan` after successful `terraform apply`, you will get the following message:
    ```
    # module.cis_dns_records[0].ibm_cis_dns_record.dns_records["NAME/SRV"] will be updated in-place
    ~ resource "ibm_cis_dns_record" "dns_records" {
            id          = "a5177ec049fc2973a33df1441e869a27:9684838a87ecxxx5518:crn:v1:bluemix:public:internet-svcs:global:a/abac0df06b644axxx4f55b3880e:6ee7ec9a-5e68-4b6f-af9a-5714xxx4d::"
        ~ name        = "_sip._udp.test-example.srv.test**.**.com" -> "test-example.srv"
            # (13 unchanged attributes hidden)
        }
    ```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cis_dns_record.dns_records](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_dns_record) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of the existing CIS instance. | `string` | n/a | yes |
| <a name="input_dns_record_set"></a> [dns\_record\_set](#input\_dns\_record\_set) | List of DNS records to be created. | <pre>list(object({<br>    name     = string<br>    type     = string<br>    ttl      = optional(number) # in unit seconds, starts with value 120<br>    content  = optional(string)<br>    priority = optional(number) # mandatory for SRV type of record<br>    proxied  = optional(bool)   # default value is false<br>    data = optional(object({<br>      altitude       = optional(number) # mandatory for LOC type of record<br>      lat_degrees    = optional(number) # mandatory for LOC type of record<br>      lat_direction  = optional(string) # mandatory for LOC type of record<br>      lat_minutes    = optional(number) # mandatory for LOC type of record<br>      lat_seconds    = optional(number) # mandatory for LOC type of record<br>      long_degrees   = optional(number) # mandatory for LOC type of record<br>      long_direction = optional(string) # mandatory for LOC type of record<br>      long_minutes   = optional(number) # mandatory for LOC type of record<br>      long_seconds   = optional(number) # mandatory for LOC type of record<br>      precision_horz = optional(number) # mandatory for LOC type of record<br>      precision_vert = optional(number) # mandatory for LOC type of record<br>      size           = optional(number) # mandatory for LOC type of record<br>      tag            = optional(string) # required for CAA type of record<br>      value          = optional(string) # required for CAA type of record<br>      target         = optional(string) # required for SRV type of record<br>      priority       = optional(number) # required for SRV type of record<br>      name           = optional(string) # required for SRV type of record<br>      port           = optional(number) # mandatory for SRV type of record<br>      proto          = optional(string) # mandatory for SRV type of record<br>      service        = optional(string) # mandatory for SRV type of record, starts with an '_'<br>      weight         = optional(number) # mandatory for SRV type of record<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | ID of the existing domain to add a DNS record. | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_dns_records"></a> [cis\_dns\_records](#output\_cis\_dns\_records) | DNS records of CIS instance |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
