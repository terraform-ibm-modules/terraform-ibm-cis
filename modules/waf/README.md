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
| <a name="input_enabled_rulesets"></a> [enabled\_rulesets](#input\_enabled\_rulesets) | List of rulesets and whether they are enabled or not | <pre>list(object({<br>    rule_name = string<br>    enabled   = bool<br>  }))</pre> | <pre>[<br>  {<br>    "enabled": true,<br>    "rule_name": "CIS Managed Ruleset"<br>  },<br>  {<br>    "enabled": true,<br>    "rule_name": "CIS Exposed Credentials Check Ruleset"<br>  },<br>  {<br>    "enabled": true,<br>    "rule_name": "CIS OWASP Core Ruleset"<br>  }<br>]</pre> | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_rulesets"></a> [rulesets](#output\_rulesets) | CIS Managed Rulesets |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
