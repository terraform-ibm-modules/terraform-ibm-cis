# CIS web application firewall (WAF) module

This module enables the web application firewall of the domain.

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
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of the existing CIS Instance. | `string` | n/a | yes |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | Existing domain ID of the CIS Instance. | `string` | n/a | yes |
| <a name="input_waf"></a> [waf](#input\_waf) | Enable a web application firewall (WAF). Supported values are off and on. | `string` | `null` | no |
| <a name="input_ssl"></a> [ssl](#input\_ssl) | Allowed values: off, flexible, full, strict, origin_pull | `string` | `"off"` | no |
| <a name="input_min_tls_version"></a> [min_tls_version](#input\_min\_tls\_version) | The minimum TLS version that you want to allow. Allowed values are 1.1, 1.2, or 1.3. | `number` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_domain_settings_details"></a> [cis\_domain\_settings\_details](#output\_cis\_domain\_settings\_details) | CIS Domain  settings details |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
