# CIS domain module

This module is used to configure the IBM Cloud Internet Services (CIS) domain.


After this module run successfully, the status of the domain that is configured in the CIS instance is set to `pending`. You then configure the name servers that are assigned to the domain at the DNS provider or registrar.

You can find the assigned name servers in the `name_servers` variable of the module output.

The status changes to `active` after the name servers are configured correctly at the DNS provider or registrar.

For more information, see [Domain lifecycle concepts](https://cloud.ibm.com/docs/cis?topic=cis-domain-lifecycle-concepts).


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
