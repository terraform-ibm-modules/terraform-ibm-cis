# End-to-end example

An end-to-end example that provisions the following infrastructure:
- Creates a new resource group, if one is not passed in.
- Creates a Cloud Internet Services (CIS) instance.
- Adds a domain to the CIS instance.
- Adds DNS records to the CIS instance.
- Adds a global load balancer including the origin pools and health checks to the CIS instance.
- A 30-second sleep time has been added to ensure that the Cloud Interface Services (CIS) instance and domain are fully configured before enabling Web Application Firewall (WAF) for the instance.
- Enables web application firewall(WAF) to the CIS instance.


For information about accessing an application through CIS, see [Configuring access to an application deployed on Red Hat OpenShift through CIS](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/docs/access-ocp-api-through-cis.md).
