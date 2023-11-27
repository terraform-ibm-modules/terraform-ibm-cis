# IBM Cloud Internet Service (CIS)
IBM Cloud Internet Services, powered by Cloudflare, provides a fast, highly performant, reliable, and secure internet service for customers running their business on IBM Cloud. The CIS provides security, reliabilty and performance features to configure for your domain such as web application firewall (WAF), distributed denial of service (DDoS), global load balancing (GLB) and domain name system(DNS). For more information see, [About IBM Cloud Internet Services](https://cloud.ibm.com/docs/cis?topic=cis-about-ibm-cloud-internet-services-cis).

## Domain

The [domain module](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/modules/domain/) provides the terraform resources required to add and configure a domain in a CIS instance. After the module run successfully-

* The status of the domain that is configured in the CIS instance is set to `pending`.
* You then configure the name servers that are assigned to the domain at the DNS provider or registrar.
* You can find the assigned name servers in the `name_servers` variable of the module output.
* The status changes to `active` after the name servers are configured correctly at the DNS provider or registrar.

For more information, see [Domain lifecycle concepts](https://cloud.ibm.com/docs/cis?topic=cis-domain-lifecycle-concepts).

## Global Load Balancer(GLB)

The global load balancing service efficiently allocates your traffic among numerous servers by utilizing a blend of origin pools, health checks, and a load balancer. Global load balancing encompasses the following functionalities:
- Load balancing options with both proxy and non-proxy configurations.
- Utilization of origin pools and health checks.

The [glb module](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/modules/glb/) provides terraform resources to create and manage global load balancers in a CIS instance. It also allows to configure health checks and other settings. For more information see [global load balancer concepts](https://cloud.ibm.com/docs/cis?topic=cis-global-load-balancer-glb-concepts).

* The module runs without any error but when `glb_proxied` is set as `true`, then `ttl` is automatically set and cannot be updated.

* This means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the `ttl` value requires an update, as shown in the following example. However, your infrastructure will not be affected.

    ```
    # module.cis_glb[0].ibm_cis_global_load_balancer.cis_glb will be updated in-place
    ~ resource "ibm_cis_global_load_balancer" "cis_glb" {
        id               = "xxx:crn:v1:bluemix:public:internet-svcs:global:a/xxxe:xxx509::"
        name             = "glb.***.com"
        ~ ttl              = 0 -> 60
    ```

## Domain Name System(DNS)

The Domain Name System (DNS) translates user-friendly website names into computer-readable numerical IP addresses. For more information see, [DNS concepts](https://cloud.ibm.com/docs/cis?topic=cis-dns-concepts).

The [DNS module](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/modules/dns) provides the terraform resource for creating and managing DNS records in a CIS instance. This inclues the ability to create dns records such as `A`, `CNAME`, `AAAA`, `SRV`, `CAA` other types of [DNS records](https://cloud.ibm.com/docs/cis?topic=cis-set-up-your-dns-for-cis) in a CIS instance.

Some of the limitations of the dns-module is as follows:
* Although the SRV record name is provided in the variable, it is stored as `_service._proto.record_name.domain_name TTL class type of record priority weight port target`. For more information, see  [What is a DNS SRV record?](https://www.cloudflare.com/en-gb/learning/dns/dns-records/dns-srv-record/).


* The changed name means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the DNS record requires an update, as shown in the following example. You can ignore that message. Your infrastructure will not be affected.

        # module.cis_dns_records[0].ibm_cis_dns_record.dns_records["NAME/SRV"] will be updated in-place
        ~ resource "ibm_cis_dns_record" "dns_records" {
            id          = "a5177ec049fc2973a33df1441e869a27:9684838a87ecxxx5518:crn:v1:bluemix:public:internet-svcs:global:a/abac0df06b644axxx4f55b3880e:6ee7ec9a-5e68-4b6f-af9a-5714xxx4d::"
            ~ name      = "_sip._udp.test-example.srv.test**.**.com" -> "test-example.srv"
            # (13 unchanged attributes hidden)
            }

* If you add a CAA record, a `flags` parameter is returned in the data object. The work is being tracked in `IBM-Cloud/terraform-provider-ibm` [issue 4792](https://github.com/IBM-Cloud/terraform-provider-ibm/issues/4792).

* The returned `flags` parameter means that when you run a `terraform plan` command after a successful `terraform apply`, the output shows that the DNS record requires an update, as shown in the following example. You can ignore that message. Your infrastructure will not be affected.

        # module.cis_dns_records.ibm_cis_dns_record.dns_records["test-exmple.caa/CAA"] will be updated in-place
        ~ resource "ibm_cis_dns_record" "dns_records" {
            ~ data        = {
                - "flags" = "0" -> null
                    # (2 unchanged elements hidden)
                }
                id        = "fcef7410xxxxxxbad23c5fd0e7581b7c:7e66xxxxxecc7e12ac908ca75445ad21:crn:v1:bluemix:public:internet-svcs:global:a/abac0df06b644axxxxx6e44f55b3880e:06240432-xxxx-40e7-9f9c-594dfbdfe208::"
                # (12 unchanged attributes hidden)
            }

## Web Application Firewall(WAF)

A Web Application Firewall (WAF) safeguards web applications by scrutinizing and overseeing HTTP traffic that flows between a web application and the internet. WAF is implemented through two rule sets: [OWASP](https://cloud.ibm.com/docs/cis?topic=cis-waf-settings#owasp-rule-set-for-waf) and [CIS](https://cloud.ibm.com/docs/cis?topic=cis-waf-settings#cis-ruleset-for-waf). For more information see, [Web Application Firewall concepts](https://cloud.ibm.com/docs/cis?topic=cis-waf-q-and-a).

Currently, the [waf module](https://github.com/terraform-ibm-modules/terraform-ibm-cis/blob/main/modules/waf/) provides terraform resources to enable and disable WAF with default policies in a CIS instance.

##  Distributed Denial of Service(DDOS)

A distributed denial of service (DDoS) attack is a malicious attempt to disrupt normal traffic of a server, service, or network by overwhelming the target or its surrounding infrastructure with a flood of internet traffic. IBM Cloud Internet Service(CIS) provides unlimited DDoS mitigation without any additional cost. To activate the DDoS protection the following conditions must be met-

  * The domain must be active.
  * The global load balancer(GLB) or DNS records needs to be proxied as mentioned in the [documentation](https://cloud.ibm.com/docs/cis?topic=cis-about-ibm-cloud-internet-services-cis).
  * In case of DNS records, CIS module only proxies traffic for `A`, `AAAA`, and `CNAME` records as described [here](https://cloud.ibm.com/docs/cli?topic=cli-cis-cli#dns-record).
