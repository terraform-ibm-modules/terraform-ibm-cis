## Accessing the api endpoint deployed on OpenShift through CIS

1. Setup an OpenShift cluster with ingress. The cluster comes with a default endpoint `/healthz`. Alternatively you can deploy your app and create the NodePort service for the application endpoint.
   The `/healthz` endpoint is accessible as:
   ```
   % oc get routes -n openshift-ingress
   NAME                                      HOST/PORT                                                                               PATH       SERVICES                  PORT   TERMINATION     WILDCARD
   route.route.openshift.io/router-default   router-default.xxx-3b5bf5f75xxxx21c8c35ad277-0000.us-south.containers.appdomain.cloud   /healthz   router-internal-default   1936   edge/Redirect   None

   % curl https://router-default.xxx-3b5bf5f75xxxx21c8c35ad277-0000.us-south.containers.appdomain.cloud/healthz
   ok
   ```
2. Open the CIS service. Navigate to DNS under `Reliability`.
3. Go to DNS records and create a new record:
   Type: CNAME
   
   Name: < any name >

   TTL: default

   
5. Create a DNS record of tyep `CNAME` in CIS that redirects to OCP ingress subdomain
    Create Pub certs using secret manager and DNS provider as CIS
    Create secrets using the certs generated in secrets manager
    Create ingress for the endpoint using CIS CNAME as host and tls secret generated in previous step
    Ingress create the route for the endpoint
    Now access the endpoint using the CIS CNAME URL. It works.


