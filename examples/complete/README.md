# End-to-end example

An end-to-end example that provisions the following infrastructure:
- Creates a new resource group, if one is not passed in.
- Creates a Cloud Internet Services (CIS) instance.
- Adds a domain to the CIS instance.
- Adds DNS records to the CIS instance.
- Adds a global load balancer including the origin pools and health checks to the CIS instance.


>To access the application deployed on OpenShift via CIS, refer [this doc](./../../access-ocp-api-through-cis.md).
