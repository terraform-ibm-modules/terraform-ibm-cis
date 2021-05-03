# IBM CIS Terraform Module

This is a collection of modules that make it easier to provision Cloud Internet Services and its resources on IBM Cloud Platform:

* [domain-and-dns_records](./modules/domain)
* [glb-origin_poold-monitor](./modules/glb)

## Compatibility

This module is meant for use with Terraform 0.13 and above versions.

## Example Usage

Full examples are in the [examples](./examples/) folder, but basic usage is as follows for creation of CIS Instance, Domains, DNS Records, Health Checks, Origin Pools, GLB:

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
  cis_id             = module.cis-domain.cis_id
  domain_id          = module.cis-domain.domain_id
  source             = "../../modules/glb"
  glb_name           = var.glb_name
  fallback_pool_name = var.fallback_pool_name
  region_pools       = local.region_pools
  origin_pools       = local.origin_pools
  monitors           = local.monitors
}
```

### NOTE: To make use of a particular version of module, Set the `version` argument to respective module version

## Requirements

### Terraform plugins

* [Terraform](https://www.terraform.io/downloads.html) >= 0.13
* [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

### Terraform

Be sure you have the correct Terraform version (>= 0.13), you can choose the binary [here](https://releases.hashicorp.com/terraform/)

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

`terraform init`

To review the plan for the configuration defined (no resources actually provisioned)

`terraform plan`

To execute and start building the configuration defined in the plan (provisions resources)

`terraform apply`

To destroy the resources

`terraform destroy`

All optional parameters by default will be set to null in respective example's varaible.tf file. If user wants to configure any optional paramter he has overwrite the default value.

## Note

All optional fields should be given value `null` in respective resource varaible.tf file. User can configure the same by overwriting with appropriate values.

### Pre-commit Hooks

Run the following command to execute the pre-commit hooks defined in `.pre-commit-config.yaml` file

  `pre-commit run -a`

We can install pre-coomit tool using

  `pip install pre-commit`

## References

[IBM-Cloud Cloud Internet Services docs](https://cloud.ibm.com/docs/cis/getting-started.html)

[IBM-Cloud Cloud Internet Services Registry docs](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis)
