# End-to-end example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<p>
  <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=cis-complete-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/examples/complete">
    <img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics">
  </a><br>
  ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
</p>
<!-- END SCHEMATICS DEPLOY HOOK -->

An end-to-end example that provisions the following infrastructure:
- Creates a new resource group, if one is not passed in.
- Creates a Cloud Internet Services (CIS) instance.
- Adds a domain to the CIS instance.
- Adds DNS records to the CIS instance.
- Adds a global load balancer including the origin pools and health checks to the CIS instance.
- Enables web application firewall (WAF) to the CIS instance.

For information about accessing an application through CIS, see [Configuring access to an application deployed on Red Hat OpenShift through CIS](https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/docs/access-ocp-api-through-cis.md).
