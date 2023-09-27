## Accessing the api endpoint deployed on OpenShift through CIS

1. Setup an OpenShift cluster with ingress. The cluster comes with a default endpoint `/healthz` that is accessible as:
   ```
   % oc get routes -n openshift-ingress
   NAME                                      HOST/PORT                                                                               PATH       SERVICES                  PORT   TERMINATION     WILDCARD
   route.route.openshift.io/router-default   router-default.xxx-3b5bf5f75xxxx21c8c35ad277-0000.us-south.containers.appdomain.cloud   /healthz   router-internal-default   1936   edge/Redirect   None

   % curl https://router-default.xxx-3b5bf5f75xxxx21c8c35ad277-0000.us-south.containers.appdomain.cloud/healthz
   ok
   ```

   Alternatively you can deploy your app and create the NodePort service for the application endpoint which should be accessible.
   
2. Open the CIS service created earlier. Navigate to `DNS` tab under `Reliability`.
 
3. Go to `DNS records` and add a new record:

   Type: CNAME
   
   Name: < any name >

   TTL: Automatic

   Alias domain name: < openshift_route >  ## example: router-default.xxx-3b5bf5f75xxxx21c8c35ad277-0000.us-south.containers.appdomain.cloud

   
4. You must have appropriate SSL certificates to redirect to `https` endpoint. The SSL certificates can be generated using [Secrets Manager](https://cloud.ibm.com/catalog/services/secrets-manager) service on IBM Cloud. Order a certificate in Secrets Manager:

    * Open the Secrets Manager service and select Secrets on the left.
    * Click Add.
    * If you are using a new Secrets Manager instance you will need to configure it prior to ordering your certificate. Follow the steps outlined under [Preparing to order public certificates](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-prepare-order-certificates&interface=ui).
    * Click on Public certificate and then click on Next.
    * Complete the form:
      ```
        Name - provide a name.
        Description - enter a description of your choice.
        Click on Next.
        Under Certificate authority select your configured Let's Encrypt certificate authority engine.
        Under Key algorithm, pick your preferred algorithm,
        Bundle certificates - leave off
        Automatic certificate rotation - leave off
        Under DNS provider select your configured DNS provider instance.
        Click on Select domains, check the subdomain and click on Done.
      ```
    * Click Next.
    * Review your selections and click on Add.
    Create Pub certs using secret manager and DNS provider as CIS
    Create secrets using the certs generated in secrets manager
    Create ingress for the endpoint using CIS CNAME as host and tls secret generated in previous step
    Ingress create the route for the endpoint
    Now access the endpoint using the CIS CNAME URL. It works.


