# Example cis_glb

This example creates Domain and manages GLB and origin pools for an existing instance .

## Example Usage

```terraform
module "cis_domain" {
  source                = "../../modules/domain"
  is_cis_instance_exist = true
  service_name          = "CISTest"
  is_cis_domain_exist   = false
  domain                = "sub.cis-terraform.com"
}
module "cis_glb" {
  source             = "../../modules/glb"
  cis_id             = module.cis_domain.cis_id
  domain_id          = module.cis_domain.domain_id
  glb_name           = join(".", [var.glb_name, var.domain])
  fallback_pool_name = local.origin_pools[0].name
  glb_description    = "Load balancer"
  glb_proxied        = true
  session_affinity   = "cookie"
  origin_pools       = local.origin_pools
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
| <a name="input_domain"></a> [domain](#input\_domain) | Domain Name that has to be created on CIS Instance | `string` | `"sub.cis-terraform.com"` | no |
| <a name="input_glb_name"></a> [glb\_name](#input\_glb\_name) | Name of CIS Global Load Balancer | `string` | `"glb"` | no |
| <a name="input_glb_proxied"></a> [glb\_proxied](#input\_glb\_proxied) | Indicates if the host name receives origin protection by IBM Cloud Internet Services. | `bool` | `false` | no |
| <a name="input_is_cis_domain_exist"></a> [is\_cis\_domain\_exist](#input\_is\_cis\_domain\_exist) | Make this as true to read existing CIS domain | `bool` | `false` | no |
| <a name="input_is_cis_instance_exist"></a> [is\_cis\_instance\_exist](#input\_is\_cis\_instance\_exist) | Make this as true to read existing CIS instance | `bool` | `false` | no |
| <a name="input_origin_server"></a> [origin\_server](#input\_origin\_server) | Name of CIS Origin server | `string` | `"os"` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | Plan of the CIS instance that has to be created | `string` | `"standard-next"` | no |
| <a name="input_pool_name"></a> [pool\_name](#input\_pool\_name) | Name of CIS Origin Pool | `string` | `"pool"` | no |
| <a name="input_region"></a> [region](#input\_region) | IBMCloud region | `string` | `"us-south"` | no |
| <a name="input_server_address"></a> [server\_address](#input\_server\_address) | Name of CIS Origin Pool | `list(string)` | <pre>[<br>  "1.1.1.1",<br>  "1.1.1.2",<br>  "1.1.1.3"<br>]</pre> | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the CIS instance that has to be created | `string` | `"CISTest"` | no |
| <a name="input_steering_policy"></a> [steering\_policy](#input\_steering\_policy) | Steering Policy | `string` | `"off"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_id"></a> [domain\_id](#output\_domain\_id) | Domain ID |
| <a name="output_glb_id"></a> [glb\_id](#output\_glb\_id) | Global Load Balancer ID |
| <a name="output_origin_pool_ids"></a> [origin\_pool\_ids](#output\_origin\_pool\_ids) | List of origin pools |
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
