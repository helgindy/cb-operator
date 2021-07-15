# CouchBase autonomous operator 2.2.0 automation

This deploys the CouchBase cluster on an existing OpenShift cluster in IBM Cloud.  [Read more about the CouchBase Autonomous Operator](https://docs.couchbase.com/operator/current/concept-operator.html).

---

## Module Variables

Variable | Type | Description | Default
---------|------|-------------|--------
`ibmcloud_api_key` | string | The IBM Cloud platform API key needed to deploy IAM enabled resources |
`ibm_region` | string | IBM Cloud region where all resources will be deployed |
`resource_group` | string | Name of resource group to create VPC | `asset-development`
`generation` | string | Generation for VPC. Can be 1 or 2 | `2`
`cluster_name` | string | Name of ROKS cluster to install operator | 
`cluster_project` | string | Name of cluster project to create then install CB operator in | 
`existing_project`|bool|Set to true if cluster project exists for operator installation, false otherwise |
`container_image_server`|string|Container image server endpoint|`registry.connect.redhat.com`
`container_image_username`|string|Container image server username| `test`
`container_image_email`|string|Container image server email address| `test@email.com`
`container_image_password`|string|Container image server password| `password`