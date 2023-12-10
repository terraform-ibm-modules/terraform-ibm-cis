# IBM Cloud Internet Service (CIS)
IBM Cloud Internet Services (CIS), powered by Cloudflare, provides security, reliability and performance for customers running their business on IBM Cloud. For more information see, [About IBM Cloud Internet Services](https://cloud.ibm.com/docs/cis?topic=cis-about-ibm-cloud-internet-services-cis)

Through this CIS module, you can manage the domain, configure DNS records, set up a global load balancer, activate the Web Application Firewall (WAF), and perform other tasks related to your domain through Terraform.

## Domain

The [domain submodule](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/modules/domain/) provides the Terraform resources that are required to add and configure a domain in a CIS instance. 

The module implements this infrastructure: 

* Sets the status of the domain that is configured in the CIS instance to `pending`.
* Configures the name servers that are assigned to the domain at the DNS provider or registrar, and then finds the assigned name servers in the `name_servers` variable of the module output.
* Sets the status of the domain changes to `active` after the name servers are configured correctly at the DNS provider or registrar.

For more information, see [Domain lifecycle concepts](https://cloud.ibm.com/docs/cis?topic=cis-domain-lifecycle-concepts).

## Domain Name System(DNS)

The [DNS submodule](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/modules/dns) provides the terraform resource for creating and managing DNS records in a CIS instance. For more information, read [this](https://cloud.ibm.com/docs/cis?topic=cis-set-up-your-dns-for-cis).

If you add a **SRV record**, though the record name is provided in the variable, it is stored as `_service._proto.record_name.domain_name TTL class type of record priority weight port target`. For more information, see  [What is a DNS SRV record?](https://www.cloudflare.com/en-gb/learning/dns/dns-records/dns-srv-record/).


The changed name means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the DNS record requires an update, as shown in the following example. You can ignore that message. Your infrastructure will not be affected.

    # module.cis_dns_records[0].ibm_cis_dns_record.dns_records["NAME/SRV"] will be updated in-place
        ~ resource "ibm_cis_dns_record" "dns_records" {
            id          = "a5177ec049fc2973a33df1441e869a27:9684838a87ecxxx5518:crn:v1:bluemix:public:internet-svcs:global:a/abac0df06b644axxx4f55b3880e:6ee7ec9a-5e68-4b6f-af9a-5714xxx4d::"
            ~ name      = "_sip._udp.test-example.srv.test**.**.com" -> "test-example.srv"
            # (13 unchanged attributes hidden)
            }

If you add a **CAA record**, a `flags` parameter is returned in the data object. The work is being tracked [here](https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4792).

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

## Global Load Balancer(GLB)

The [glb submodule](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/modules/glb/) provides terraform resources to create and manage global load balancers in a CIS instance. It also allows to configure health checks, origin pools and proxy settings. For more information see [global load balancer concepts](https://cloud.ibm.com/docs/cis?topic=cis-global-load-balancer-glb-concepts).

When `glb_proxied` is set as `true`, then `ttl` is automatically set and cannot be updated.

This means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the `ttl` value requires an update, as shown in the following example. However, your infrastructure will not be affected and you can ignore that message.

```
# module.cis_glb[0].ibm_cis_global_load_balancer.cis_glb will be updated in-place
    ~ resource "ibm_cis_global_load_balancer" "cis_glb" {
        id               = "xxx:crn:v1:bluemix:public:internet-svcs:global:a/xxxe:xxx509::"
        name             = "glb.***.com"
        ~ ttl              = 0 -> 60
```

## Web Application Firewall(WAF)

The [WAF submodule](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/modules/waf/) provides the terraform resources that allow you to turn on and off WAF. CIS includes the default rule sets for WAF: [OWASP rule set](https://cloud.ibm.com/docs/cis?topic=cis-waf-settings#owasp-rule-set-for-waf) and [CIS rule set](https://cloud.ibm.com/docs/cis?topic=cis-waf-settings#cis-ruleset-for-waf). Currently this module allows you to either enable or disable the WAF with these default rule sets.

##  Distributed Denial of Service(DDOS)

To activate the DDoS protection the following conditions must be met-

  * The domain must be active.
  * The global load balancer(GLB) or DNS records needs to be proxied as mentioned in the [documentation](https://cloud.ibm.com/docs/cis?topic=cis-about-ibm-cloud-internet-services-cis).

> The CIS provides DDoS protection by proxying traffic for some specific types of DNS records, such as `A`, `AAAA`, and `CNAME` records as mentioned [here](https://cloud.ibm.com/docs/cli?topic=cli-cis-cli#dns-record).
