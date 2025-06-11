# Profile for IBM Cloud Framework for Financial Services

This code is a version of the [parent root module](../../) that includes a default configuration that complies with the relevant controls from the [IBM Cloud Framework for Financial Services](https://cloud.ibm.com/docs/framework-financial-services?topic=framework-financial-services-about). See the [Example for IBM Cloud Framework for Financial Services](/examples/fscloud/) for logic that uses this module.

## Manual Actions

After this module runs successfully, the status of the domain that is configured in the CIS instance is set to `pending`. You need to configure the name servers that are assigned to the domain at the DNS provider and then the status of the domain will be changed to `active`. This manual step must be taken after deploying and configuring the instance to ensure compliance with the IBM Cloud Framework for Financial Services.

For more information, read [here](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/docs/README.md).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.79.0, < 2.0.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.10.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cis_dns_records"></a> [cis\_dns\_records](#module\_cis\_dns\_records) | ../../modules/dns | n/a |
| <a name="module_cis_glb"></a> [cis\_glb](#module\_cis\_glb) | ../../modules/glb | n/a |
| <a name="module_cis_instance"></a> [cis\_instance](#module\_cis\_instance) | ../../ | n/a |
| <a name="module_waf"></a> [waf](#module\_waf) | ../../modules/waf | n/a |

### Resources

| Name | Type |
|------|------|
| [time_sleep.wait_for_cis_instance](https://registry.terraform.io/providers/hashicorp/time/0.10.0/docs/resources/sleep) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_dns_records"></a> [add\_dns\_records](#input\_add\_dns\_records) | Set to true if dns records to be added to the CIS instance | `bool` | `false` | no |
| <a name="input_add_glb"></a> [add\_glb](#input\_add\_glb) | Set to true if global load balancer(glb) to be added to the CIS instance | `bool` | `false` | no |
| <a name="input_default_pool_ids"></a> [default\_pool\_ids](#input\_default\_pool\_ids) | List of default pool IDs. | `list(string)` | `null` | no |
| <a name="input_dns_record_set"></a> [dns\_record\_set](#input\_dns\_record\_set) | List of DNS records to be added for the CIS Instance. | <pre>list(object({<br>    name     = string<br>    type     = string<br>    ttl      = optional(number) # in unit seconds, starts with value 120<br>    content  = optional(string)<br>    priority = optional(number) # mandatory for SRV type of record<br>    proxied  = optional(bool)   # default value is false<br>    data = optional(object({<br>      altitude       = optional(number) # mandatory for LOC type of record<br>      lat_degrees    = optional(number) # mandatory for LOC type of record<br>      lat_direction  = optional(string) # mandatory for LOC type of record<br>      lat_minutes    = optional(number) # mandatory for LOC type of record<br>      lat_seconds    = optional(number) # mandatory for LOC type of record<br>      long_degrees   = optional(number) # mandatory for LOC type of record<br>      long_direction = optional(string) # mandatory for LOC type of record<br>      long_minutes   = optional(number) # mandatory for LOC type of record<br>      long_seconds   = optional(number) # mandatory for LOC type of record<br>      precision_horz = optional(number) # mandatory for LOC type of record<br>      precision_vert = optional(number) # mandatory for LOC type of record<br>      size           = optional(number) # mandatory for LOC type of record<br>      tag            = optional(string) # required for CAA type of record<br>      value          = optional(string) # required for CAA type of record<br>      target         = optional(string) # required for SRV type of record<br>      priority       = optional(number) # required for SRV type of record<br>      port           = optional(number) # mandatory for SRV type of record<br>      proto          = optional(string) # mandatory for SRV type of record<br>      service        = optional(string) # mandatory for SRV type of record, starts with an '_'<br>      weight         = optional(number) # mandatory for SRV type of record<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name to be added to the CIS instance. | `string` | n/a | yes |
| <a name="input_enable_waf"></a> [enable\_waf](#input\_enable\_waf) | To control whether the web application firewall (WAF) is enabled or disabled for a CIS instance. | `bool` | `true` | no |
| <a name="input_enable_waf_rulesets"></a> [enable\_waf\_rulesets](#input\_enable\_waf\_rulesets) | List of rulesets to be enabled for web application firewal(WAF). For more information, refer to the [IBM Cloud Managed Rules Overview](https://cloud.ibm.com/docs/cis?topic=cis-managed-rules-overview). | `list(string)` | <pre>[<br>  "CIS Managed Ruleset",<br>  "CIS Exposed Credentials Check Ruleset",<br>  "CIS OWASP Core Ruleset"<br>]</pre> | no |
| <a name="input_fallback_pool_id"></a> [fallback\_pool\_id](#input\_fallback\_pool\_id) | ID of the fallback pool. Required if fallback\_pool\_name is not provided. | `string` | `null` | no |
| <a name="input_fallback_pool_name"></a> [fallback\_pool\_name](#input\_fallback\_pool\_name) | FallBack Pool Name. Required if fallback\_pool\_id is not provided. | `string` | `null` | no |
| <a name="input_glb_description"></a> [glb\_description](#input\_glb\_description) | Description of the CIS global load balancer. | `string` | `null` | no |
| <a name="input_glb_enabled"></a> [glb\_enabled](#input\_glb\_enabled) | Whether the CIS global load balancer is enabled. If set to true, the load balancer is enabled and can receive network traffic. | `bool` | `null` | no |
| <a name="input_glb_name"></a> [glb\_name](#input\_glb\_name) | The DNS name to associate with CIS global load balancer. It can be a hostname. | `string` | `null` | no |
| <a name="input_health_checks"></a> [health\_checks](#input\_health\_checks) | List of health checks to be created for the CIS global load balancer. | <pre>list(object({<br>    name             = string<br>    description      = optional(string)<br>    path             = optional(string)<br>    type             = optional(string)<br>    port             = optional(number)<br>    expected_body    = string<br>    expected_codes   = string<br>    method           = optional(string)<br>    timeout          = optional(number)<br>    follow_redirects = optional(bool)<br>    allow_insecure   = optional(bool)<br>    interval         = optional(number)<br>    retries          = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_origin_pools"></a> [origin\_pools](#input\_origin\_pools) | List of origins with an associated health check to be created for the CIS global load balancer. | <pre>list(object({<br>    name = string<br>    origins = list(object({<br>      name    = string<br>      address = string<br>      enabled = optional(bool)<br>      weight  = optional(number)<br>    }))<br>    enabled            = bool # if set to true, the pool is enabled and can receive incoming network traffic<br>    description        = optional(string)<br>    check_regions      = list(string) # list of region codes<br>    minimum_origins    = optional(number)<br>    health_check_name  = optional(string)<br>    notification_email = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | The type of plan for the CIS instance: standard-next or trial. | `string` | `"trial"` | no |
| <a name="input_pop_pools"></a> [pop\_pools](#input\_pop\_pools) | Pop pools of the CIS global load balancer. | <pre>list(object({<br>    pop      = string<br>    pool_ids = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_region_pools"></a> [region\_pools](#input\_region\_pools) | Region pools of the CIS global load balancer. | <pre>list(object({<br>    region   = string<br>    pool_ids = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The resource group ID to provision the CIS instance. | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the CIS instance. | `string` | n/a | yes |
| <a name="input_session_affinity"></a> [session\_affinity](#input\_session\_affinity) | Session Affinity of the CIS global load balancer. To make use of session affinity, glb\_proxied has to be true. | `string` | `null` | no |
| <a name="input_steering_policy"></a> [steering\_policy](#input\_steering\_policy) | Steering Policy of the CIS global load balancer. | `string` | `"off"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags to be associated to the CIS instance. | `list(string)` | `[]` | no |
| <a name="input_use_legacy_waf"></a> [use\_legacy\_waf](#input\_use\_legacy\_waf) | Set to true to enable/disable the old way of enabling WAF. To enable WAF by using managed rulesets, please use variable 'enable\_waf\_rulesets'. For more information, refer [this](https://cloud.ibm.com/docs/cis?topic=cis-migrating-to-managed-rules) | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cis_dns_records"></a> [cis\_dns\_records](#output\_cis\_dns\_records) | DNS records of CIS instance |
| <a name="output_cis_domain"></a> [cis\_domain](#output\_cis\_domain) | CIS Domain details |
| <a name="output_cis_glb_id"></a> [cis\_glb\_id](#output\_cis\_glb\_id) | ID of CIS GLB |
| <a name="output_cis_instance_guid"></a> [cis\_instance\_guid](#output\_cis\_instance\_guid) | GUID of CIS instance |
| <a name="output_cis_instance_id"></a> [cis\_instance\_id](#output\_cis\_instance\_id) | CRN of CIS instance |
| <a name="output_cis_instance_name"></a> [cis\_instance\_name](#output\_cis\_instance\_name) | CIS instance name |
| <a name="output_cis_instance_status"></a> [cis\_instance\_status](#output\_cis\_instance\_status) | Status of CIS instance |
| <a name="output_cis_waf_rulesets"></a> [cis\_waf\_rulesets](#output\_cis\_waf\_rulesets) | WAF rulesets of CIS instance |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
