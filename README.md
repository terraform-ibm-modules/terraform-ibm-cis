# IBM Cloud Internet Services Module

You can use this module to provision an IBM Cloud Internet Services (CIS) instance and then add domain, dns records, global load balancer (GLB), origin pools and health checks for GLB for the provisioned CIS.

For more information see [Getting started with IBM Cloud Internet Services](https://cloud.ibm.com/docs/cis?topic=cis-getting-started).

<!-- BEGIN ADD_OVERVIEW HOOK -->
## Overview
* [terraform-ibm-cis](#terraform-ibm-cis)
* [Submodules](./modules)
    * [cis-domain-module](./modules/cis-domain-module)
    * [cis-dns-module](./modules/cis-dns-module)
    * [cis-glb-module](./modules/cis-glb-module)
* [Examples](./examples)
    * [Complete example](./examples/complete)

## terraform-ibm-cis
<!-- END AND_OVERVIEW HOOK -->

## Usage

```terraform
provider "ibm" {
  ibmcloud_api_key = ""
}

module "cis_instance" {
  source            = "terraform-ibm-modules/cis/ibm"
  version           = "latest" # Replace "latest" with a release version to lock into a specific release
  service_name      = "example-cis"
  resource_group_id = "000fb3134f214c3a9017554db4510f70" # pragma: allowlist secret
  plan              = "standard-next"
}

module "cis_domain" {
  source                = "terraform-ibm-modules/cis/ibm//cis-domain-module"
  domain_name           = "sub.cis-terraform.com"
  cis_instance_id       = module.cis_instance.cis_instance_id
}

module "cis_dns_records" {
  source          = "terraform-ibm-modules/cis/ibm//cis-dns-module"
  cis_instance_id = module.cis_instance.cis_instance_id
  domain_id       = module.cis_domain.cis_domain.domain_id
  dns_record_set      = [
    {
      type    = "A"
      name    = "test-example"
      content = "1.2.3.4"
      ttl     = 900
    }
  ]
}

module "cis_glb" {
  source             = "terraform-ibm-modules/cis/ibm//cis-glb-module"
  cis_instance_id    = module.cis_instance.cis_instance_id
  domain_id          = module.cis_domain.cis_domain.domain_id
  glb_name           = "cis_glb"
  fallback_pool_name = "cis_fpn"
  glb_enabled        = true
  origin_pools       = [
    {
      name = "glb1"
      origins = [{
        name    = "o-1"
        address = "1.1.1.0"
        enabled = true
        }]
      enabled           = true
      description       = "Test GLB"
      check_regions     = ["WEU"]
      health_check_name = "hc1"
    }
  ]
  health_checks       = [
    {
      expected_body  = "alive"
      expected_codes = "200"
      method         = "GET"
      timeout        = 7
      path           = "/health"
      interval       = 60
      retries        = 3
      name           = "hc1"
    }
  ]
}
```


## Required IAM access policies

You need the following permissions to run this module.

- Account Management
  - **Resource Group** services
    - `Editor` platform access
- IAM Services
  - **Cloud Internet** service
    - `Editor` platform access


## Examples

* [Complete example that creates CIS instance and add domain, dns records, global load balancer](examples/complete)


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
| <a name="output_cis_instance_guid"></a> [cis\_instance\_guid](#output\_cis\_instance\_guid) | GUID of CIS instance |
| <a name="output_cis_instance_id"></a> [cis\_instance\_id](#output\_cis\_instance\_id) | CRN of CIS instance |
| <a name="output_cis_instance_name"></a> [cis\_instance\_name](#output\_cis\_instance\_name) | CIS instance name |
| <a name="output_cis_instance_status"></a> [cis\_instance\_status](#output\_cis\_instance\_status) | Status of CIS instance |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
