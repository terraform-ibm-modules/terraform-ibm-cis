# Module CIS GLB

This module is used to provision Global Load Balancers, Origin pools and monitors.

## Example Usage

```terraform
module "cis-glb" {
  cis_id             = var.cis_id
  domain_id          = var.domain_id
  source             = "../../modules/glb"
  glb_name           = var.glb_name
  fallback_pool_name = var.fallback_pool_name
  region_pools       = local.region_pools
  origin_pools       = local.origin_pools
  monitors           = local.monitors
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## GLB Inputs

| Name                                  | Description                                                       | Type     | Default | Required |
|---------------------------------------|-------------------------------------------------------------------|----------|---------|----------|
| cis_id    | The CRN of CIS Instance.                                | string   | n/a     | yes       |
| domain_id                      | The ID of CIS Instance Domain.                                       | string   | n/a     | yes       |
| glb_name                          | The Name of GLB that has to be created.                                  | string   | n/a     |yes    |
| fallback_pool_name                   | The Name of the fallback Pool. This name should be chosen from the origin pools that are been created in this module| string   | n/a     | yes     |
| fallback_pool_id                 | FallBack Pool Id. Conflicts with fallback_pool_name    | string   | n/a     | no       |
| default_pool_ids | ID's of Default Pools. If default pool Id's are not provided, All the pools that are created in this module will be considered as default pools| list(str) | n/a     | no       |
| glb_description                   | Description of CIS Global Load Balancer | string   | n/a     | no     |
| glb_proxied                 | Proxy of CIS Global Load Balancer              | string   | n/a     | no       |
| session_affinity                 | Session Affinity of CIS Global Load Balancer                      | string | n/a     | no       |
| glb_enabled                   | Enable / Disable of CIS Global Load Balancer                    | bool   | n/a     | no     |
| ttl                 | TTL of CIS Global Load Balancer       | number   | n/a     | no       |
| region_pools                 | Region Pools of CIS Global Load Balancer            | list(obj) | []     | no       |
| pop_pools                 | Pop Pools of CIS Global Load Balancer        | list(obj) | []     | no       |

### region_pools Object

| Name                                 | Description           | Type   | Default | Required |
|--------------------------------------|-----------------------|--------|---------|----------|
| region                                 | Region of the Pool | string | n/a     | no       |
| pool_names                             | List of the pool names to be attached to the specified region. These names should be chosen from the origin pools that are been created in this module | list(string) | n/a     | no       |
| pool_ids                             | Conflicts with `pool_names`. List of pool Id's | list(string) | n/a     | no       |

### pop_pools Object

| Name                                 | Description           | Type   | Default | Required |
|--------------------------------------|-----------------------|--------|---------|----------|
| pop                                 | Pop of the Pool | string | n/a     | no       |
| pool_names                             | List of the pools to be attached to the region. These names should be chosen from the origin pools that are been created in this module | list(string) | n/a     | no       |
| pool_ids                             | Conflicts with `pool_names`. List of pool Id's | list(string) | n/a     | no       |


## Origin Pool Inputs

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| origin_pools           | List of objects of origin pools. If not provided, pools will not be created. | list(obj) | n/a     | no      |

### origin_pools Object

| Name                                 | Description           | Type   | Default | Required |
|--------------------------------------|-----------------------|--------|---------|----------|
| name                                 | A short name for the pool | string | n/a     | yes       |
| origins                             | The list of origins within this pool. Find the origins object in below table. | list(obj) | n/a     | yes       |
| check_regions                       | A list of regions (specified by region code) from which to run health checks. Empty means every region (the default), but requires an Enterprise plan. Region codes can be found on our partner Cloudflare's website here. | list(string) | n/a     | yes       |
| description                                 | Free text description. | string | n/a     | no       |
| enabled                                 | Whether to enable (the default) this pool. Disabled pools will not receive traffic and are excluded from health checks. Disabling a pool will cause any load balancers using it to failover to the next pool (if any).| string | n/a     | no       |
| minimum_origins        | The minimum number of origins that must be healthy for this pool to serve traffic. If the number of healthy origins falls below this number, the pool will be marked unhealthy and we will failover to the next available pool.   | string | n/a     | no       |
| notification_email     | The email address to send health status notifications to. | string | n/a     | no       |
| monitor_name   | The ID of the Monitor to use for health checking origins within this pool. Name should be chosen from the monitor that has been created in this module. | string | n/a     | no       |
| monitor_id    | Conflicts with `monitor_name`. The ID of the Monitor to use for health checking origins within this pool. | string | n/a     | no       |

### origins Object

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| name           | Name for the origin. | string | n/a     | yes      |
| address           | The IP address (IPv4 or IPv6) of the origin, or the publicly addressable hostname. Hostnames entered here should resolve directly to the origin, and not be a hostname proxied by CIS. | string | n/a     | yes      |
| enabled           | Whether to enable (the default) this origin within the Pool. Disabled origins will not receive traffic and are excluded from health checks. The origin will only be disabled for the current pool. | bool | n/a     | no      |
| weight           | The origin pool weight. | float | n/a     | no      |

## Health Check / Monitor Inputs

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| monitors           | List of objects of health checkss. If not provided, healthchecks/monitors will not be created. | list(obj) | n/a     | no      |

### monitors Object

| Name                                 | Description           | Type   | Default | Required |
|--------------------------------------|-----------------------|--------|---------|----------|
| name         |  Name/Description of healthcheck. This name is used as name of resource in this module and hence avoid spaces | string | n/a     | yes   |
| path      | The endpoint path to health check against. | string | `/`     | no       |
| type   | The protocol to use for the healthcheck. | string | `HTTP`    | no       |
| port  | The TCP port to use for the health check.| number | n/a     | no       |
| expected_body       |   A case-insensitive sub-string to look for in the response body. If this string is not found, the origin will be marked as unhealthy. A null value of "" is allowed to match on any content.| string | n/a     | no       |
| expected_codes   | The expected HTTP response code or code range of the health check | string | n/a     | no       |
| method     | The HTTP method to use for the health check. | string | `GET`    | no       |
| timeout      | The timeout (in seconds) before marking the health check as failed. | number | 5    | no   |
| follow_redirects         |  Follow redirects if returned by the origin. | bool | n/a     | no       |
| allow_insecure        | Do not validate the certificate when healthcheck use HTTPS. | bool | n/a     | no       |
| interval                |The interval between each health check. Shorter intervals may improve failover time, but will increase load on the origins as we check from multiple locations | number | 60    | no       |
| retries        | The number of retries to attempt in case of a timeout before marking the origin as unhealthy. Retries are attempted immediately. | number | 2    | no       |
| headers     | The health check headers. Find the headers object in below table. | list(obj) | []   | no   |

### NOTE: `expected_body`,`expected_codes` are required when the type is `HTTP` or `HTTPS`

### headers Object

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| header           | The value of header. | string | n/a     | yes      |
| values           | The List of values for header field. | list(string) | n/a     | yes      |

## Outputs

| Name                                    | Description                           |
|-----------------------------------------|---------------------------------------|
| glb_id           | Id of CIS GLB |
| origin_pool_ids           | Ids of CIS origin pools |
| health_check_id           | Id of CIS Health Check |

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
