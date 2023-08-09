# Module CIS DNS

This module is used to manage CIS DNS Records.

## Example Usage

```terraform
module "cis_dns_records" {
  source                = "../../modules/dns"
  domain_id             = var.domain_id
  cis_id                = var.cis_instance_id
  records               = [
    {
      type    = "A"
      name    = "test-example1"
      content = "1.2.3.4"
      ttl     = 900
    },
    {
      name    = "test-example.caa"
      type    = "CAA"
      ttl     = 900
      data = {
        tag   = "http"
        value = "domain.com"
      }
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
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
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | ID of the CIS instance | `string` | n/a | yes |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | ID of the domain to add a DNS record | `string` | n/a | yes |
| <a name="input_record_set"></a> [record\_set](#input\_record\_set) | Create DNS records of CIS Instance | <pre>list(object({<br>    name     = optional(string)<br>    type     = string<br>    ttl      = optional(number) # in unit seconds, starts with value 120<br>    content  = optional(string)<br>    priority = optional(number) # mandatory for SRV type of record<br>    proxied  = optional(bool)   # default value is false<br>    data = optional(object({<br>      altitude       = optional(number) # mandatory for LOC type of record<br>      lat_degrees    = optional(number) # mandatory for LOC type of record<br>      lat_direction  = optional(string) # mandatory for LOC type of record<br>      lat_minutes    = optional(number) # mandatory for LOC type of record<br>      lat_seconds    = optional(number) # mandatory for LOC type of record<br>      long_degrees   = optional(number) # mandatory for LOC type of record<br>      long_direction = optional(string) # mandatory for LOC type of record<br>      long_minutes   = optional(number) # mandatory for LOC type of record<br>      long_seconds   = optional(number) # mandatory for LOC type of record<br>      precision_horz = optional(number) # mandatory for LOC type of record<br>      precision_vert = optional(number) # mandatory for LOC type of record<br>      tag            = optional(string)<br>      value          = optional(string)<br>      target         = optional(string)<br>      priority       = optional(number)<br>      size           = optional(number) # mandatory for LOC type of record<br>      name           = optional(string) # required for SRV type of record<br>      port           = optional(number) # mandatory for SRV type of record<br>      proto          = optional(string) # mandatory for SRV type of record<br>      service        = optional(string) # mandatory for SRV type of record, starts with an '_'<br>      weight         = optional(number) # mandatory for SRV type of record<br>    }))<br>  }))</pre> | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_dns_records"></a> [cis\_dns\_records](#output\_cis\_dns\_records) | DNS records of CIS instance |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Usage

Initialising Provider

Make sure you declare a required providers ibm block to make use of IBM-Cloud Terraform Provider

```terraform
terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "<version>"  // Specify the version
    }
  }
}
```

```terraform
terraform init
```

```terraform
terraform plan
```

```terraform
terraform apply
```
