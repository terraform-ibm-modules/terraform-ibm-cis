# Module CIS Domain

This module is used to manage CIS DNS Records.

## Example Usage

```terraform
module "cis_domain" {
  source                = "../../modules/dns"
  domain                = "sub.cis-terraform.com"
  cis_id                = var.cis_instance_id
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
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | ID of CIS instance | `string` | n/a | yes |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | Domain ID of CIS Instance | `string` | n/a | yes |
| <a name="input_record_set"></a> [record\_set](#input\_record\_set) | Create DNS records of CIS Instance | <pre>list(object({<br>    name     = optional(string)<br>    type     = string<br>    ttl      = optional(number)<br>    content  = optional(string)<br>    priority = optional(number)<br>    data = optional(object({<br>      altitude       = optional(number)<br>      lat_degrees    = optional(number)<br>      lat_direction  = optional(string)<br>      lat_minutes    = optional(number)<br>      lat_seconds    = optional(number)<br>      long_degrees   = optional(number)<br>      long_direction = optional(string)<br>      long_minutes   = optional(number)<br>      long_seconds   = optional(number)<br>      precision_horz = optional(number)<br>      precision_vert = optional(number)<br>      size           = optional(number)<br>      tag            = optional(string)<br>      value          = optional(string)<br>      port           = optional(number)<br>      priority       = optional(number)<br>      proto          = optional(string)<br>      service        = optional(string)<br>      target         = optional(string)<br>      weight         = optional(number)<br>      name           = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_dns_records"></a> [cis\_dns\_records](#output\_cis\_dns\_records) | CIS DNS records |
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
