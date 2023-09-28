## Accessing the api endpoint deployed on OpenShift through CIS

1. Setup an OpenShift cluster with ingress. The cluster comes with a default endpoint `/healthz` that is accessible as:
   ```
   % oc get routes -n openshift-ingress
   NAME                                      HOST/PORT                                                                               PATH       SERVICES                  PORT   TERMINATION     WILDCARD
   route.route.openshift.io/router-default   router-default.xxx-3b5bf5f75xxxx21c8c35ad277-0000.us-south.containers.appdomain.cloud   /healthz   router-internal-default   1936   edge/Redirect   None

   % curl https://router-default.xxx-3b5bf5f75xxxx21c8c35ad277-0000.us-south.containers.appdomain.cloud/healthz
   ok
   ```

   Alternatively you deploy your app and create the NodePort service for the application endpoint.

2. Open the CIS service and navigate to `DNS` tab under `Reliability`.

3. Go to `DNS records` and add a new record:
   ```
   Type: CNAME
   Name: <any name>
   TTL: Automatic
   Alias domain name: <openshift_route>  ## example: router-default.xxx-3b5bf5f75xxxx21c8c35ad277-0000.us-south.containers.appdomain.cloud
   ```

4. If CIS domain is `example.com` and DNS record name provided in step 3 is `test` then the endpoint can be accessed via `https://test.example.com/<api_endpoint>`. If you access the link now, you will get `ssl handshake failure` error as below.
   ```
   % curl -v https://test.example.com/<api_endpoint>
   *   Trying [2606:4000:10::xy43:xy0]:443...
   * Connected to test.example.com (2606:4000:10::xy43:xy0) port 443 (#0)
   * ALPN: offers h2,http/1.1
   * (304) (OUT), TLS handshake, Client hello (1):
   *  CAfile: /etc/ssl/cert.pem
   *  CApath: none
   * LibreSSL/3.3.6: error:1404B410:SSL routines:ST_CONNECT:sslv3 alert handshake failure
   * Closing connection 0
   curl: (35) LibreSSL/3.3.6: error:1404B410:SSL routines:ST_CONNECT:sslv3 alert handshake failure
   ```

   It is because the client or server is not able to establish a secure connection.


5. To establish a secure connection between client and server, you need to have appropriate SSL certificates. The SSL certificates can be generated using [Secrets Manager](https://cloud.ibm.com/catalog/services/secrets-manager) service on IBM Cloud. Order a certificate in Secrets Manager:

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

6. Download the certificates in Secrets Manager. It has `<cert_name>.key` and `<cert_name>.pem` file.

7. Create secrets in OpenShift using the downloaded certificates.
   ```
   oc project openshift-ingress
   oc create secret tls <secret_name> --cert=<path_of_pem_file> --key=<path_of_key_file>
   ```

8. Create ingress for the endpoint using CIS CNAME as host and tls secret generated in previous step.
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

9. It creates the route for the endpoint. You can validate the route as:
   ```
   oc get routes
   ```

10. You can access the endpoint using the CIS CNAME URL `https://test.example.com/<api_endpoint>`.
    ```
    % curl https://test.example.com/healthz
    ok
    ```
