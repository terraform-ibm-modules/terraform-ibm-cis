# CIS domain module

This module is used to configure the IBM Cloud Internet Services (CIS) domain. For more information, see the [main readme file](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/docs/README.md) for this module.

### Usage

```
provider "ibm" {
  ibmcloud_api_key = ""
}

module "cis_domain" {
    source          = "terraform-ibm-modules/cis/ibm/dns"
    cis_instance_id = "crn:v1:bluemix:public:internet-svcs:global:a/xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX:xxxxxxxx-XXXX-xxxx-XXXX-xxxxxXXXXxxxx::"
    domain_name = "my-domain-name"
    domain_type = "full"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.63.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cis_domain.cis_domain](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_domain) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of the existing CIS instance. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name to be added to the CIS instance. | `string` | n/a | yes |
| <a name="input_domain_type"></a> [domain\_type](#input\_domain\_type) | The type of domain for the CIS instance: full or partial. Default value is full for regular domains. | `string` | `"full"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_domain_details"></a> [cis\_domain\_details](#output\_cis\_domain\_details) | CIS Domain details |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
