# CIS web application firewall (WAF) module

This module enables/disables the web application firewall (WAF) of the domain. For more information, see the [main readme file](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/docs/README.md) for this module.

>  Before enabling Web Application Firewall (WAF), the Cloud Interface Services (CIS) instance and domain must be properly configured. For more detailed information, see the [complete example](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/examples/complete/main.tf).

### Usage
```
provider "ibm" {
  ibmcloud_api_key = ""
}

module "cis_waf"{
    cis_instance_id = "crn:v1:bluemix:public:internet-svcs:global:a/xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX:xxxxxxxx-XXXX-xxxx-XXXX-xxxxxXXXXxxxx::"
    domain_id       = "xxxxXXXXxxxxXXXXxxxxxxxxXXXXxxxx"
    enable_cis_managed_ruleset = true
    enable_cis_exposed_creds_check_ruleset = true
    enable_cis_owasp_core_ruleset = true
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.70.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cis_ruleset_entrypoint_version.config](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_ruleset_entrypoint_version) | resource |
| [ibm_cis_rulesets.rulesets](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/cis_rulesets) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of the existing CIS instance. | `string` | n/a | yes |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | ID of the existing domain to add a DNS record to the CIS instance. | `string` | n/a | yes |
| <a name="input_enable_cis_exposed_creds_check_ruleset"></a> [enable\_cis\_exposed\_creds\_check\_ruleset](#input\_enable\_cis\_exposed\_creds\_check\_ruleset) | To control whether to enable CIS Exposed Credentials Check Ruleset | `bool` | `false` | no |
| <a name="input_enable_cis_managed_ruleset"></a> [enable\_cis\_managed\_ruleset](#input\_enable\_cis\_managed\_ruleset) | To control whether to enable CIS Managed Ruleset | `bool` | `false` | no |
| <a name="input_enable_cis_owasp_core_ruleset"></a> [enable\_cis\_owasp\_core\_ruleset](#input\_enable\_cis\_owasp\_core\_ruleset) | To control whether to enable CIS Owasp Core Ruleset | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_rulesets"></a> [rulesets](#output\_rulesets) | CIS Managed Rulesets |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
