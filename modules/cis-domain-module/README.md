# Module CIS Domain

This module is used to manage CIS Domains.


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
| [ibm_cis_domain.cis_domain](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_domain) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of an existing CIS instance. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | DNS domain name to add to the CIS instance. | `string` | n/a | yes |
| <a name="input_domain_type"></a> [domain\_type](#input\_domain\_type) | Type of domain to be created. Default value is full for regular domains. To create a partial domain for CNAME setup, set this variable to partial. | `string` | `"full"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_domain"></a> [cis\_domain](#output\_cis\_domain) | CIS Domain details |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
