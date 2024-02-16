# Financial Services Cloud profile example

An end-to-end example that provisions the following:
- Creates a new resource group, if one is not passed in.
- Creates a Cloud Internet Services (CIS) instance.
- Adds a domain to the CIS instance.
- Adds proxied DNS records to the CIS instance.
- Adds a proxied global load balancer including the origin pools and health checks to the CIS instance.
- Enables web application firewall(WAF) to the CIS instance.

Note: In order for a domain to become active, a manual action is required. After the domain becomes active, DDoS protection will be enabled.
