# CIS GLB module

This module provisions a global load balancer that includes load balancers, origin pools, and health checks. For more information, see the [main readme file](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/docs/README.md) for this module.

### Usage
```
provider "ibm" {
  ibmcloud_api_key = ""
}

module "cis_glb" {
  source             = "terraform-ibm-modules/cis/ibm//glb"
  cis_instance_id = "crn:v1:bluemix:public:internet-svcs:global:a/xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX:xxxxxxxx-XXXX-xxxx-XXXX-xxxxxXXXXxxxx::"
  domain_id       = "xxxxXXXXxxxxXXXXxxxxxxxxXXXXxxxx"
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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.63.0 |

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
| <a name="input_cis_instance_id"></a> [cis\_instance\_id](#input\_cis\_instance\_id) | CRN of the existing CIS Instance. | `string` | n/a | yes |
| <a name="input_default_pool_ids"></a> [default\_pool\_ids](#input\_default\_pool\_ids) | List of default pool IDs. | `list(string)` | `null` | no |
| <a name="input_domain_id"></a> [domain\_id](#input\_domain\_id) | Existing domain ID of the CIS Instance. | `string` | n/a | yes |
| <a name="input_fallback_pool_id"></a> [fallback\_pool\_id](#input\_fallback\_pool\_id) | ID of the fallback pool. Required if fallback\_pool\_name is not provided. | `string` | `null` | no |
| <a name="input_fallback_pool_name"></a> [fallback\_pool\_name](#input\_fallback\_pool\_name) | FallBack Pool Name. Required if fallback\_pool\_id is not provided. | `string` | `null` | no |
| <a name="input_glb_description"></a> [glb\_description](#input\_glb\_description) | Description of the CIS global load balancer. | `string` | `null` | no |
| <a name="input_glb_enabled"></a> [glb\_enabled](#input\_glb\_enabled) | Whether the CIS global load balancer is enabled. If set to true, the load balancer is enabled and can receive network traffic. | `bool` | n/a | yes |
| <a name="input_glb_name"></a> [glb\_name](#input\_glb\_name) | The DNS name to associate with CIS global load balancer. It can be a hostname. | `string` | n/a | yes |
| <a name="input_glb_proxied"></a> [glb\_proxied](#input\_glb\_proxied) | Set to true if the host name receives origin protection by IBM CIS instance. | `bool` | `null` | no |
| <a name="input_health_checks"></a> [health\_checks](#input\_health\_checks) | List of health checks to be created for the CIS global load balancer. | <pre>list(object({<br>    name             = string<br>    description      = optional(string)<br>    path             = optional(string)<br>    type             = optional(string)<br>    port             = optional(number)<br>    expected_body    = string<br>    expected_codes   = string<br>    method           = optional(string)<br>    timeout          = optional(number)<br>    follow_redirects = optional(bool)<br>    allow_insecure   = optional(bool)<br>    interval         = optional(number)<br>    retries          = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_origin_pools"></a> [origin\_pools](#input\_origin\_pools) | List of origins with an associated health check to be created for the CIS global load balancer. | <pre>list(object({<br>    name = string<br>    origins = list(object({<br>      name    = string<br>      address = string<br>      enabled = optional(bool)<br>      weight  = optional(number)<br>    }))<br>    enabled            = bool # if set to true, the pool is enabled and can receive incoming network traffic<br>    description        = optional(string)<br>    check_regions      = list(string) # list of region codes<br>    minimum_origins    = optional(number)<br>    health_check_name  = optional(string)<br>    notification_email = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_pop_pools"></a> [pop\_pools](#input\_pop\_pools) | Pop pools of the CIS global load balancer. | <pre>list(object({<br>    pop      = string<br>    pool_ids = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_region_pools"></a> [region\_pools](#input\_region\_pools) | Region pools of the CIS global load balancer. | <pre>list(object({<br>    region   = string<br>    pool_ids = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_session_affinity"></a> [session\_affinity](#input\_session\_affinity) | Session Affinity of the CIS global load balancer. To make use of session affinity, glb\_proxied has to be true. | `string` | `null` | no |
| <a name="input_steering_policy"></a> [steering\_policy](#input\_steering\_policy) | Steering Policy of the CIS global load balancer. | `string` | `"off"` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | Time to live (TTL) for the CIS global load balancer (GLB), in seconds. If the GLB is proxied, the value is set automatically. | `number` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_glb_id"></a> [glb\_id](#output\_glb\_id) | ID of CIS GLB |
| <a name="output_health_check_id"></a> [health\_check\_id](#output\_health\_check\_id) | IDs of CIS Health Checks |
| <a name="output_origin_pool_ids"></a> [origin\_pool\_ids](#output\_origin\_pool\_ids) | IDs of CIS origin pools |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
