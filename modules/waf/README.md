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
    enabled_rulesets = ["CIS Managed Ruleset", "CIS Exposed Credentials Check Ruleset", "CIS OWASP Core Ruleset"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.70.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cis_domain_settings.domain_settings](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_domain_settings) | resource |
| [ibm_cis_ruleset_entrypoint_version.config](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_ruleset_entrypoint_version) | resource |
| [ibm_cis_rulesets.rulesets](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/cis_rulesets) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of the existing CIS instance. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Enable Web application firewall for domain | `string` | `"Enable WAF using managed rulesets"` | no |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | ID of the existing domain to add a DNS record to the CIS instance. | `string` | n/a | yes |
| <a name="input_enable_waf"></a> [enable\_waf](#input\_enable\_waf) | To control whether the web application firewall (WAF) is enabled or disabled for a CIS instance. | `bool` | `true` | no |
| <a name="input_enabled_rulesets"></a> [enabled\_rulesets](#input\_enabled\_rulesets) | List of rulesets to be enabled. For more information, refer to the [IBM Cloud Managed Rules Overview](https://cloud.ibm.com/docs/cis?topic=cis-managed-rules-overview). | `list(string)` | <pre>[<br>  "CIS Managed Ruleset",<br>  "CIS Exposed Credentials Check Ruleset",<br>  "CIS OWASP Core Ruleset"<br>]</pre> | no |
| <a name="input_use_legacy_waf"></a> [use\_legacy\_waf](#input\_use\_legacy\_waf) | Set to true to enable/disable the old way of enabling WAF. To enable WAF by using managed rulesets, please use variable 'enabled\_rulesets'. For more information, refer [this](https://cloud.ibm.com/docs/cis?topic=cis-migrating-to-managed-rules) | `bool` | `false` | no |

### Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
