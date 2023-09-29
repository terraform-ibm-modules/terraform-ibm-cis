# Configuring access to an application deployed on Red Hat OpenShift through CIS

## Before you begin

***OpenShift Configuration***

* Create a [RedHat OpenShift on IBM Cloud](https://cloud.ibm.com/docs/openshift?topic=openshift-getting-started&interface=ui).
* Deploy an app on the OpenShift cluster and create the service for the application endpoint. This document reuses a `/healthz` end point which comes with the default deployment.

***CIS Configuration***
* Create CIS instance. You can use the [terraform module](https://github.com/terraform-ibm-modules/terraform-ibm-cis) to create and configure CIS.
* An active domain of CIS instance.


## Add a DNS entry

1. Login to [IBM Cloud](https://cloud.ibm.com) and click on your CIS instance under `Resources List`. Navigate to `DNS` tab under `Reliability`.

2. Go to `DNS records` and add a new record:

   ```
   Type: CNAME
   Name: <any name>
   TTL: Automatic
   Alias domain name: <openshift_route>  ## example: router-default.xxx-3b5bf5f75xxxx21c8c35ad277-0000.us-south.containers.appdomain.cloud
   ```

   Make a note of the CIS domain and DNS record name. You need it later to access the application from CIS.

   >If CIS domain is `example.com`, DNS record name is `test` and application endpoint is `/healthz` then the URL to access will be `https://test.example.com/healthz`.  This endpoint is not accessible this time because the certificates are not set for https protocol and you will get ssl handshake failure error.

3. To establish a secure connection between client and server, you need to have appropriate SSL certificates. The SSL certificates can be generated using [Secrets Manager](https://cloud.ibm.com/catalog/services/secrets-manager) service on IBM Cloud. Order a certificate in Secrets Manager:

    * Open the Secrets Manager service and select `Secrets` on the left.
    * Click `Add`.
    * If you are using a new Secrets Manager instance you will need to configure it prior to ordering your certificate. Follow the steps outlined under [Preparing to order public certificates](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-prepare-order-certificates&interface=ui).
    * Click on `Public certificate` and then click on `Next`.
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
    * Click `Next`.
    * Review your selections and click on `Add`.


4. Download the certificates in Secrets Manager. It has `<cert_name>.key` and `<cert_name>.pem` file.

5. Run the following commands on the command line to create secrets in your cluster that use the downloaded certificates.

   ```sh
   ibmcloud login --apikey <apikey>
   ibmcloud oc cluster config -c <your_openshift_cluster_id> --admin
   oc project openshift-ingress  #switch to the project where your application is deployed
   oc create secret tls <secret_name> --cert=<path_of_pem_file> --key=<path_of_key_file>
   ```

6. Create ingress for the endpoint using CIS CNAME as host and tls secret generated in previous step. Save the following configuration as `ingress.yaml` and update according to your domain, secret, path, service and port.

   ```
   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: myingressresource
   spec:
    tls:
    - hosts:
      - test.example.com
     secretName: <secret_name>
   rules:
   - host: test.example.com
     http:
      paths:
      - path: /healthz
        pathType: ImplementationSpecific
        backend:
            service:
                name: router-internal-default
                port:
                    number: 1936
   ```

   Apply the configuration.

   ```
   oc apply -f ingress.yaml
   ```

7. It creates the route for the endpoint. You can validate the route as:

   ```
   oc get routes
   ```

8. Verify that you can access your application at the endpoint that you created in [Add a DNS entry](#add-a-dns-entry). For example, 

    ```sh
    curl https://test.example.com/healthz
    ok
    ```
