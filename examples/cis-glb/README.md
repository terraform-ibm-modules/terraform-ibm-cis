# Example cis-glb

This example creates Domain and manages GLB and origin pools for an existing instance .

## Example Usage

```terraform
module "cis-domain" {
  source                = "../../modules/domain"
  is_cis_instance_exist = true
  service_name          = var.service_name
  is_cis_domain_exist   = false
  domain                = var.domain
}
module "cis-glb" {
  source             = "../../modules/glb"
  cis_id             = module.cis-domain.cis_id
  domain_id          = module.cis-domain.domain_id
  glb_name           = join(".", [var.glb_name, var.domain])
  fallback_pool_name = local.origin_pools[0].name
  glb_description    = "Load balancer"
  glb_proxied        = true
  session_affinity   = "cookie"
  origin_pools       = local.origin_pools
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
| glb_name            | The Name of GLB that has to be created.       | string   | n/a     |yes    |
| pool_name          |Prefix for the Name of Origin Pools that has to be created. | string   | n/a     |yes    |
| origin_server            | Prefix for the Name of Origins that has to be created. | string   | n/a     |yes    |
| server_address            | List of server addresses for origins | list(string)  | n/a     |yes    |


## Local Variables

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| origin_pools           | List of objects of origin pools. If not provided, pools will not be created. | list(obj) | n/a     | no      |

### origin_pools Object

| Name                                 | Description           | Type   | Default | Required |
|--------------------------------------|-----------------------|--------|---------|----------|
| name                                 | A short name for the pool | string | n/a     | yes       |
| origins                             | The list of origins within this pool. Find the origins object in below table. | list(obj) | n/a    | yes       |
| enabled                                 | Whether to enable (the default) this pool. Disabled pools will not receive traffic and are excluded from health checks. Disabling a pool will cause any load balancers using it to failover to the next pool (if any).| string | n/a     | no       |

### origins Object

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| name           | Name for the origin. | string | n/a     | yes      |
| address           | The IP address (IPv4 or IPv6) of the origin, or the publicly addressable hostname. Hostnames entered here should resolve directly to the origin, and not be a hostname proxied by CIS. | string | n/a     | yes      |
| enabled           | Whether to enable (the default) this origin within the Pool. Disabled origins will not receive traffic and are excluded from health checks. The origin will only be disabled for the current pool. | bool | n/a     | no      |
| weight           | The origin pool weight. | float | n/a     | no      |

## Outputs

| Name                                    | Description                           |
|-----------------------------------------|---------------------------------------|
| domain_id           | ID id CIS Domain |
| origin_pool_ids           | Ids of CIS origin Pools |
| glb_id           | Ids of CIS GLB |

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
