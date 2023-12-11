# Features of IBM Cloud Internet Service (CIS) services

IBM Cloud Internet Services (CIS), powered by Cloudflare, provides security, reliability and performance for customers running their business on IBM Cloud. The CIS module incorporates several submodules such as domain, dns, glb and waf to configure enhanced security and reliability for a CIS instance. Through this module, you can configure the domain, manage DNS records, set up a global load balancer, activate the Web Application Firewall (WAF), and perform other tasks. For more information see, [About IBM Cloud Internet Services](https://cloud.ibm.com/docs/cis?topic=cis-about-ibm-cloud-internet-services-cis)

## About the CIS submodules

### Domain submodule

The [domain submodule](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/modules/domain/) provides the Terraform resources that are required to add and configure a domain in a CIS instance. For more information, see [Domain lifecycle concepts](https://cloud.ibm.com/docs/cis?topic=cis-domain-lifecycle-concepts).

After this module run successfully, the status of the domain that is configured in the CIS instance is set to `pending`. You then configure the name servers that are assigned to the domain at the DNS provider or registrar. You can find the assigned name servers in the `name_servers` variable of the module output. The status changes to `active` after the name servers are configured correctly at the DNS provider or registrar.


### DNS submodule

The [Domain name system (DNS) submodule](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/modules/dns) provides the Terraform resources to create and manage DNS records in a CIS instance. For more information, see [Setting up your Domain Name System for CIS](https://cloud.ibm.com/docs/cis?topic=cis-set-up-your-dns-for-cis).

If you add a SRV record, it is stored as `_service._proto.record_name.domain_name TTL class type of record priority weight port target`. This is true even though the record name is provided in the variable. For more information, see  [What is a DNS SRV record?](https://www.cloudflare.com/en-gb/learning/dns/dns-records/dns-srv-record/).

The changed name means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the DNS record requires an update, as shown in the following example. You can ignore that message. Your infrastructure will not be affected.

    # module.cis_dns_records[0].ibm_cis_dns_record.dns_records["NAME/SRV"] will be updated in-place
        ~ resource "ibm_cis_dns_record" "dns_records" {
            id          = "a5177ec049fc2973a33df1441e869a27:9684838a87ecxxx5518:crn:v1:bluemix:public:internet-svcs:global:a/abac0df06b644axxx4f55b3880e:6ee7ec9a-5e68-4b6f-af9a-5714xxx4d::"
            ~ name      = "_sip._udp.test-example.srv.test**.**.com" -> "test-example.srv"
            # (13 unchanged attributes hidden)
            }

If you add a CAA record, a `flags` parameter is returned in the data object. The work is being tracked [here](https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4792).

The returned `flags` parameter means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the DNS record requires an update, as shown in the following example. You can ignore that message. Your infrastructure will not be affected.

    # module.cis_dns_records.ibm_cis_dns_record.dns_records["test-exmple.caa/CAA"] will be updated in-place
        ~ resource "ibm_cis_dns_record" "dns_records" {
            ~ data        = {
                - "flags" = "0" -> null
                    # (2 unchanged elements hidden)
                }
                id        = "fcef7410xxxxxxbad23c5fd0e7581b7c:7e66xxxxxecc7e12ac908ca75445ad21:crn:v1:bluemix:public:internet-svcs:global:a/abac0df06b644axxxxx6e44f55b3880e:06240432-xxxx-40e7-9f9c-594dfbdfe208::"
                # (12 unchanged attributes hidden)
            }

This module allows you to import DNS records from a file in the following two ways :

- by specifying the file path directly
- by using a base64-encoded string representation of the file

To convert the records text file to base64 encoded string:
```sh
cat dns_records.txt | base64
```

If you successfully import DNS records using the base64 encoded string method, and then run a `terraform plan` command, you will receive a message stating that the `ibm_cis_dns_records_import` resource and the `local_file` resource need to be forcefully replaced as shown below. This happens because the `local_file` resource block generates a unique filename everytime and therefore needs to be updated. However, if you do `terraform apply` then the DNS records will not get duplicated and infrastructure remains the same.

    # module.cis_dns_records.ibm_cis_dns_records_import.import_dns_records[0] must be replaced
    -/+ resource "ibm_cis_dns_records_import" "import_dns_records" {
      ~ file                 = "../../modules/dns/dns_records_2023-12-10T09" # forces replacement -> (known after apply) #
      ~ records_added        = 3 -> (known after apply)
      ~ total_records_parsed = 3 -> (known after apply)
    }
    # module.cis_dns_records.local_file.dns_record_file[0] must be replaced
    -/+ resource "local_file" "dns_record_file" {
      ~ filename             = "../../modules/dns/dns_records_2023-12-10T09:29:24Z.txt"-> (known after apply) # forces replacement
      ~ id                   = "de87dcxxxxfec671eexxxxxxxxx30accaxxxxa13" -> (known after apply)
        # (3 unchanged attributes hidden)
    }
        Plan: 2 to add, 0 to change, 2 to destroy.

It shows the following changes to output as below. You can ignore that message. Your infrastructure will not be affected.

    Changes to Outputs:
    ~ cis_dns_records     = {
        ~ cis_imported_dns_records = [
            ~ {
                ~ file                 = "../../modules/dns/dns_records_2023-12-10T09:45:59Z.txt" -> (known after apply)
                ~ id                   = "3:3:../../modules/dns/dns_records_2023-12-10T09:45:59Z.txt:e47cxxxxx7caf0xxxxx452395xxxxxfe:crn:v1:bluemix:public:internet-svcs:global:a/abxxxxx06xxxxa9cxxxxx44f5xxxxx0e:exxx8xx5-7xx1-4xx1-bxxe-2xxxxa2xxxxf::" -> (known after apply)
                + records_added        = (known after apply)
                + total_records_parsed = (known after apply)
                },
            ]
    }

### GLB submodule

The [Global load balancer (GLB) submodule](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/modules/glb/) provides Terraform resources to create and manage global load balancers in a CIS instance. It also allows to configure health checks, origin pools and proxy settings. For more information see [Global load balancer concepts](https://cloud.ibm.com/docs/cis?topic=cis-global-load-balancer-glb-concepts).

When `glb_proxied` is set as `true`, then `ttl` is automatically set and cannot be updated.

This means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the `ttl` value requires an update, as shown in the following example. However, your infrastructure will not be affected and you can ignore that message.

```
# module.cis_glb[0].ibm_cis_global_load_balancer.cis_glb will be updated in-place
    ~ resource "ibm_cis_global_load_balancer" "cis_glb" {
        id               = "xxx:crn:v1:bluemix:public:internet-svcs:global:a/xxxe:xxx509::"
        name             = "glb.***.com"
        ~ ttl              = 0 -> 60
```

### WAF submodule

The [Web Application Firewall (WAF) submodule](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/modules/waf/) provides the Terraform resources to turn WAF on and off. CIS includes the default rule sets for WAF: the [OWASP rule set](https://cloud.ibm.com/docs/cis?topic=cis-waf-settings#owasp-rule-set-for-waf) and the [CIS rule set](https://cloud.ibm.com/docs/cis?topic=cis-waf-settings#cis-ruleset-for-waf). You can either enable or disable the WAF with these default rule sets.

##  Activating DDOS protection

CIS can provide protection against distributed denial of service (DDoS) attacks by proxying traffic for some types of DNS records, such as `A`, `AAAA`, and `CNAME` records. For more information, see the [DNS record](https://cloud.ibm.com/docs/cli?topic=cli-cis-cli#dns-record) section of the CIS CLI reference.

Activating DDoS protection requires that you set the following conditions:

  * The domain must be active.
  * The global load balancer( GLB) or DNS records must be proxied.

For more information about proxy options, see [About IBM Cloud Internet Services](https://cloud.ibm.com/docs/cis?topic=cis-about-ibm-cloud-internet-services-cis).
