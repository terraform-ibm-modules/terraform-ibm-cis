# Example dns-and-glb

This example is used to create DNS Records, GLB, Origin Pools, Monitors using existing Instance and Domain.

## Example Usage

```terraform
module "cis-domain" {
  source                = "../../modules/domain"
  is_cis_instance_exist = true
  service_name          = var.service_name
  is_cis_domain_exist   = true
  domain                = var.domain
  record_set            = local.record_set
}
module "cis-glb" {
  source             = "../../modules/glb"
  cis_id             = module.cis-domain.cis_id
  domain_id          = module.cis-domain.domain_id
  glb_name           = var.glb_name
  fallback_pool_name = var.fallback_pool_name
  region_pools       = local.region_pools
  origin_pools       = local.origin_pools
  monitors           = local.monitors
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| ibmcloud_api_key           | IBM-Cloud Api Key | string | n/a     | yes      |
| region           | IBM Cloud region | string | n/a     | yes      |
| service_name           | Name of the CIS instance | string | n/a     | yes      |
| domain           | Domain name of CIS Instance | string | n/a     | yes      |
| glb_name                          | The Name of GLB that has to be created.                                  | string   | n/a     |yes    |
| fallback_pool_name   | The Name of the fallback Pool. This name should be chosen from the origin pools that are been created in this module| string   | n/a     | yes     |

## Local Variables

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| record_set           | List of objects of DNS Records. If not provided, Records will not be created. | list(obj) | n/a     | no      |
| region_pools         | Region Pools of CIS Global Load Balancer            | list(obj) | []     | no       |
| origin_pools           | List of objects of origin pools. If not provided, pools will not be created. | list(obj) | n/a     | no      |
| monitors     | List of objects of health checkss. If not provided, healthchecks/monitors will not be created. | list(obj) | n/a | no  |

### record_set Object

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| name           | The name of a DNS record. | string | n/a     | yes      |
| type           | The type of the DNS record to be created.| string | n/a     | yes      |
| content           | The (string) value of the record, e.g. "192.168.127.127". Conflicts with `data` | string | n/a     | no      |
| data           | Map of attributes that constitute the record value. Only for LOC, CAA and SRV record types. Find the keys of map in below table. This attribute conflicts with `content`| map | n/a     | yes      |
| ttl           | TTL of the record. It should be automatic(i.e ttl=1) if the record is proxied. Terraform provider takes ttl in unit seconds. Therefore, it starts with value 120. | number | n/a     | no      |
| priority           | The priority of the record. Mandatory field for SRV record type. | number | n/a     | no      |
| proxied           | Whether the record gets CIS's origin protection | bool | n/a     | no      |

### data MAP

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| weight |  The weight of distributing queries among multiple target servers. Mandatory field for SRV record | number| n/a|no|
| port |  The port number of the target server. Mandatory field for SRV record.| number| n/a|no|
| service |  The symbolic name of the desired service, start with an underscore (\_). Mandatory field for SRV record.| number| n/a|no|
| protocol |  The symbolic name of the desired protocol. Madatory field for SRV record.| number| n/a|no|
| altitude |  The LOC altitude. Mondatory field for LOC record.| number| n/a|no|
| size |  The LOC altitude size. Mondatory field for LOC record.| number| n/a|no|
| lat_degrees |  The LOC latitude degrees. Mondatory field for LOC record.| number| n/a|no|
| lat_direction |  The LOC latitude direction ("N", "E", "S", "W"). Mondatory field for LOC record.| string | n/a|no|
| lat_minutes |  The LOC latitude minutes. Mondatory field for LOC record.| number| n/a|no|
| lat_seconds |  The LOC latitude seconds. Mondatory field for LOC record.| number| n/a|no|
| long_degrees |  The LOC Longitude degrees. Mondatory field for LOC record.| number| n/a|no|
| long_direction |  The LOC longitude direction ("N", "E", "S", "W"). Mondatory field for LOC record.| string| n/a|no|
| long_minutes |  The LOC longitude minutes. Mondatory field for LOC record.| number| n/a|no|
| long_seconds |  The LOC longitude seconds. Mondatory field for LOC record.| number| n/a|no|
| precision_horz |  The LOC horizontal precision. Mondatory field for LOC record.| number| n/a|no|
| precision_vert |  The LOC vertical precision. Mondatory field for LOC record.| number| n/a|no|
| priority |  The priority of the record| number| n/a|no|

### region_pools Object

| Name                                 | Description           | Type   | Default | Required |
|--------------------------------------|-----------------------|--------|---------|----------|
| region                                 | Region of the Pool | string | n/a     | no       |
| pool_names                             | List of the pool names to be attached to the specified region. These names should be chosen from the origin pools that are been created in this module | list(string) | n/a     | no       |
| pool_ids                             | Conflicts with `pool_names`. List of pool Id's | list(string) | n/a     | no       |

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
| dns_record_ids           | Ids CIS DNS Records |
| origin_pool_ids           | Ids of CIS origin Pools |

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
