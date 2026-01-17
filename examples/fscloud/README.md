# Financial Services Cloud profile example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=cis-fscloud-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-cis/tree/main/examples/fscloud"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom;"></a>
<!-- END SCHEMATICS DEPLOY HOOK -->


An end-to-end example that provisions the following:
- Creates a new resource group, if one is not passed in.
- Creates a Cloud Internet Services (CIS) instance.
- Adds a domain to the CIS instance.
- Adds proxied DNS records to the CIS instance.
- Enables web application firewall(WAF) to the CIS instance.

Note: To enable DDoS protection, the domain must be activated.

<!-- BEGIN SCHEMATICS DEPLOY TIP HOOK -->
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
<!-- END SCHEMATICS DEPLOY TIP HOOK -->
