# CIS web application firewall (WAF) module

This module enables/disables the web application firewall (WAF) of the domain. For more information, see the [main readme file](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/docs/README.md) for this module.

>  Before enabling Web Application Firewall (WAF) for the instance the Cloud Interface Services (CIS) instance and domain must be properly configured. For more detailed information, see the [complete example](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/examples/complete/main.tf).

### Usage
```
provider "ibm" {
  ibmcloud_api_key = ""
}

module "cis_waf"{
    cis_instance_id = "crn:v1:bluemix:public:internet-svcs:global:a/xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX:xxxxxxxx-XXXX-xxxx-XXXX-xxxxxXXXXxxxx::"
    domain_id       = "xxxxXXXXxxxxXXXXxxxxxxxxXXXXxxxx"
    waf = "on"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, <1.6.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cis_domain_settings.domain_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_domain_settings) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of the existing CIS instance. | `string` | n/a | yes |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | ID of the existing domain to add a DNS record to the CIS instance. | `string` | n/a | yes |
| <a name="input_enable_waf"></a> [enable\_waf](#input\_enable\_waf) | To control whether the web application firewall (WAF) is enabled or disabled for a CIS instance. | `bool` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_domain_settings_details"></a> [cis\_domain\_settings\_details](#output\_cis\_domain\_settings\_details) | CIS Domain settings details |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
