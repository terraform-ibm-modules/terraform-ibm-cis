# Module CIS Domain

This module is used to manage CIS Instance, CIS Domains, CIS DNS Records.

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

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## CIS Instance and Domain Inputs

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| is_cis_instance_exist | Determines if cis instance exits or not. If set false it will create a cis instance with given name. | bool | n/a | yes  |
| service_name           | Name of the CIS instance | string | n/a     | yes      |
| plan           | Plan of the CIS instance that has to be created | string | n/a     | yes      |
| resource_group_id     | Resource group ID in which CIS instance that has to be created | string | n/a     | yes      |
| tags           | Tags attached to CIS Instance | list(string) | n/a     | no      |
| is_cis_domain_exist      | Determines if cis domains exits or not. If set false it will create a cis domain | bool | n/a     | yes      |
| domain           | Domain name of CIS Instance | string | n/a     | yes      |

### NOTE: If `is_cis_instance_exist` is set to true, Following attributes `plan`, `resource_group_id`,`tags` are not required

## CIS DNS Records Inputs

| Name                                    | Description                           | Type   | Default | Required |
|-----------------------------------------|---------------------------------------|--------|---------|----------|
| record_set           | List of objects of DNS Records. If not provided, Records will not be created. | list(obj) | n/a     | no      |

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


## Outputs

| Name                                    | Description                           |
|-----------------------------------------|---------------------------------------|
| cis_id           | CRN of CIS Service Instance |
| domain_id           | ID id CIS Domain |
| ibm_cis           | Details of CIS Service Instance |
| ibm_domain           | Details id CIS Domain|
| dns_record_ids           | Ids CIS DNS Records |
| dns_records           | Details of CIS DNS Records |

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
