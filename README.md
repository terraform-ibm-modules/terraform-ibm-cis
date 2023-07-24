# IBM CIS Terraform Module

Collection of modules that make it easier to provision Cloud Internet Services and its resources on IBM Cloud Platform:

## Compatibility

This module is meant for use with Terraform 0.13 and above versions.

## Example Usage

Examples are covered in `examples` folder, but basic usage is as follows for creation of CIS Instance, Domains, DNS Records, Health Checks, Origin Pools, GLB:

```terraform
module "cis_domain" {
  source                = "../../modules/domain"
  is_cis_instance_exist = true
  service_name          = "CisTest"
  is_cis_domain_exist   = true
  domain                = "sub.cis-terraform.com"
  record_set            = local.record_set
}
module "cis_glb" {
  source             = "../../modules/glb"
  cis_id             = module.cis_domain.cis_id
  domain_id          = module.cis_domain.domain_id
  glb_name           = "cis_glb"
  fallback_pool_name = "cis_fpn"
  region_pools       = local.region_pools
  origin_pools       = local.origin_pools
  monitors           = local.monitors
}
```

## Requirements

### Terraform plugins

* [Terraform](https://www.terraform.io/downloads.html) >= 0.13
* [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

### Terraform

Be sure you have the correct Terraform version (>= 0.13), you can choose the binary [here](https://releases.hashicorp.com/terraform/)

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

`terraform init`

To review the plan for the configuration defined (no resources actually provisioned)

`terraform plan`

To execute and start building the configuration defined in the plan (provisions resources)

`terraform apply`

To destroy the resources

`terraform destroy`


## References

[IBM-Cloud Cloud Internet Services docs](https://cloud.ibm.com/docs/cis/getting-started.html)

[IBM-Cloud Cloud Internet Services Registry docs](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis)

## Contributing

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0, < 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cis.cis_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_plan"></a> [plan](#input\_plan) | Plan for the CIS instance. Standard-next or trial. | `string` | `"trial"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource group ID where CIS instance will be created. | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the CIS instance. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags to be associated to CIS instance. | `list(string)` | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_instance_crn"></a> [cis\_instance\_crn](#output\_cis\_instance\_crn) | CRN of CIS instance |
| <a name="output_cis_instance_guid"></a> [cis\_instance\_guid](#output\_cis\_instance\_guid) | GUID of CIS instance |
| <a name="output_cis_instance_name"></a> [cis\_instance\_name](#output\_cis\_instance\_name) | CIS instance name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
