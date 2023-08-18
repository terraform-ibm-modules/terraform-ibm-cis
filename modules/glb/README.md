# Module CIS GLB

This module is used to provision Global Load Balancers, Origin pools and monitors.

## Example Usage

```terraform
module "cis_glb" {
  cis_id             = var.cis_id
  domain_id          = var.domain_id
  source             = "../../modules/glb"
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
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cis_global_load_balancer.cis_glb](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_global_load_balancer) | resource |
| [ibm_cis_healthcheck.health_check](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_healthcheck) | resource |
| [ibm_cis_origin_pool.origin_pool](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_origin_pool) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of CIS Service Instance. | `string` | n/a | yes |
| <a name="input_default_pool_ids"></a> [default\_pool\_ids](#input\_default\_pool\_ids) | Default Pool IDs. | `list(string)` | `null` | no |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | Domain ID of CIS Service Instance. | `string` | n/a | yes |
| <a name="input_fallback_pool_id"></a> [fallback\_pool\_id](#input\_fallback\_pool\_id) | FallBack Pool ID. Conflicts with fallback\_pool\_name | `string` | `null` | no |
| <a name="input_fallback_pool_name"></a> [fallback\_pool\_name](#input\_fallback\_pool\_name) | FallBack Pool Name. Conflicts with fallback\_pool\_id | `string` | n/a | yes |
| <a name="input_glb_description"></a> [glb\_description](#input\_glb\_description) | Description of CIS Global Load Balancer | `string` | `null` | no |
| <a name="input_glb_enabled"></a> [glb\_enabled](#input\_glb\_enabled) | To enable / disable CIS Global Load Balancer. If set to true, the load balancer is enabled and can receive network traffic. | `bool` | n/a | yes |
| <a name="input_glb_name"></a> [glb\_name](#input\_glb\_name) | Name of CIS Global Load Balancer. | `string` | n/a | yes |
| <a name="input_glb_proxied"></a> [glb\_proxied](#input\_glb\_proxied) | Proxy of CIS Global Load Balancer. Default value if false. | `bool` | `false` | no |
| <a name="input_monitors"></a> [monitors](#input\_monitors) | List of monitors to be created | <pre>list(object({<br>    name             = string<br>    description      = optional(string)<br>    path             = optional(string)<br>    type             = optional(string)<br>    port             = optional(number)<br>    expected_body    = string<br>    expected_codes   = string<br>    method           = optional(string)<br>    timeout          = optional(number)<br>    follow_redirects = optional(bool)<br>    allow_insecure   = optional(bool)<br>    interval         = optional(number)<br>    retries          = optional(number)<br>    headers = optional(list(object({<br>      header = optional(string)<br>      values = optional(string) #Note Header is not currently supported in this version of the provider.<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_origin_pools"></a> [origin\_pools](#input\_origin\_pools) | List of objects of origin pools | <pre>list(object({<br>    name = string<br>    origins = list(object({<br>      name    = string<br>      address = string<br>      enabled = optional(bool)<br>      weight  = optional(number)<br>    }))<br>    enabled            = bool # if set to true, the pool is enabled and can receive incoming network traffic<br>    description        = optional(string)<br>    check_regions      = list(string) # list of region codes<br>    minimum_origins    = optional(number)<br>    monitor_name       = optional(string)<br>    notification_email = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_pop_pools"></a> [pop\_pools](#input\_pop\_pools) | Pop Pools of CIS Global Load Balancer | <pre>list(object({<br>    pop      = string<br>    pool_ids = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_region_pools"></a> [region\_pools](#input\_region\_pools) | Region Pools of CIS Global Load Balancer | <pre>list(object({<br>    region   = string<br>    pool_ids = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_session_affinity"></a> [session\_affinity](#input\_session\_affinity) | Session Affinity of CIS Global Load Balancer | `string` | `null` | no |
| <a name="input_steering_policy"></a> [steering\_policy](#input\_steering\_policy) | Steering Policy of CIS Global Load Balancer | `string` | `"off"` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | time-to-live(TTL) of CIS Global Load Balancer in seconds. Allowed value is 120 or greater if GLB is not in proxy. | `number` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_glb_id"></a> [glb\_id](#output\_glb\_id) | ID of CIS GLB |
| <a name="output_health_check_id"></a> [health\_check\_id](#output\_health\_check\_id) | ID of CIS Health Check |
| <a name="output_origin_pool_ids"></a> [origin\_pool\_ids](#output\_origin\_pool\_ids) | IDs of CIS origin pools |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

### NOTE: To make use of a particular version of module, Set the `version` argument to respective module version


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
