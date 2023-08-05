# Example dns-and-glb

This example is used to create DNS Records, GLB, Origin Pools, Monitors using existing Instance and Domain.

## Example Usage

```terraform
module "cis_domain" {
  source                = "../../modules/domain"
  is_cis_instance_exist = true
  service_name          = "CISTest"
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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.49.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cis_domain"></a> [cis\_domain](#module\_cis\_domain) | ../../modules/domain | n/a |
| <a name="module_cis_glb"></a> [cis\_glb](#module\_cis\_glb) | ../../modules/glb | n/a |

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | Domain Name that has to be created on CIS Instance | `string` | `"cis-terraform.com"` | no |
| <a name="input_fallback_pool_name"></a> [fallback\_pool\_name](#input\_fallback\_pool\_name) | FallBack Pool Name. Conflicts with fallback\_pool\_id | `string` | `"op1"` | no |
| <a name="input_glb_name"></a> [glb\_name](#input\_glb\_name) | Name of CIS Global Load Balancer | `string` | `"test.cis-terraform.com"` | no |
| <a name="input_is_cis_domain_exist"></a> [is\_cis\_domain\_exist](#input\_is\_cis\_domain\_exist) | Make this as true to read existing CIS domain | `bool` | `false` | no |
| <a name="input_is_cis_instance_exist"></a> [is\_cis\_instance\_exist](#input\_is\_cis\_instance\_exist) | Make this as true to read existing CIS instance | `bool` | `false` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | Plan of the CIS instance that has to be created | `string` | `"standard-next"` | no |
| <a name="input_region"></a> [region](#input\_region) | IBMCloud region | `string` | `"us-south"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the CIS instance that has to be created | `string` | `"CISTest"` | no |
| <a name="input_steering_policy"></a> [steering\_policy](#input\_steering\_policy) | Steering Policy | `string` | `"off"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_record_ids"></a> [dns\_record\_ids](#output\_dns\_record\_ids) | List of DNS record IDs |
| <a name="output_origin_pool_ids"></a> [origin\_pool\_ids](#output\_origin\_pool\_ids) | List of origin pool IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


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

```terraform
terraform init
```

```terraform
terraform plan
```

```terraform
terraform apply
```
