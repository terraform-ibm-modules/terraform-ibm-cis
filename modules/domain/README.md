# Module CIS Domain

This module is used to manage CIS Instance, CIS Domains, CIS DNS Records.

## Example Usage

```terraform
module "cis_domain" {
  source                = "../../modules/domain"
  is_cis_instance_exist = true
  service_name          = "CISTest"
  is_cis_domain_exist   = true
  domain                = "sub.cis-terraform.com"
  record_set            = local.record_set
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
| [ibm_cis.cis_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis) | resource |
| [ibm_cis_dns_record.dns_rescords](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_dns_record) | resource |
| [ibm_cis_domain.cis_domain](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_domain) | resource |
| [ibm_cis.cis_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/cis) | data source |
| [ibm_cis_domain.cis_domain](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/cis_domain) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | Domain name of CIS Instance | `string` | n/a | yes |
| <a name="input_is_cis_domain_exist"></a> [is\_cis\_domain\_exist](#input\_is\_cis\_domain\_exist) | Determines if cis domains exits or not. If set true it will not create a cis domain | `bool` | `null` | no |
| <a name="input_is_cis_instance_exist"></a> [is\_cis\_instance\_exist](#input\_is\_cis\_instance\_exist) | Determines if cis instance exits or not. If set true it will not create a cis instance | `bool` | `null` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | Plan of the CIS instance that has to be created | `string` | n/a | yes |
| <a name="input_record_set"></a> [record\_set](#input\_record\_set) | Set objects of CIS Service Instance DNS Records that has to be created | <pre>list(object({<br>    name    = string<br>    type    = string<br>    ttl     = number<br>    content = string<br>    data = object({<br>      altitude       = number<br>      lat_degrees    = number<br>      lat_direction  = string<br>      lat_minutes    = number<br>      lat_seconds    = number<br>      long_degrees   = number<br>      long_direction = string<br>      long_minutes   = number<br>      long_seconds   = number<br>      precision_horz = number<br>      precision_vert = number<br>      size           = number<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource group ID in which CIS instance that has to be created | `string` | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the CIS instance. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags attached to CIS Instance | `list(string)` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_id"></a> [cis\_id](#output\_cis\_id) | CRN of CIS Service Instance |
| <a name="output_dns_record_ids"></a> [dns\_record\_ids](#output\_dns\_record\_ids) | Ids CIS DNS Records |
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | ID id CIS Domain |
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
