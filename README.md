# CouchBase Cluster on Red Hat OpenShift on VPC Gen 2

These modules allow for the creation of a OpenShift cluster on IBM Cloud VPC Gen 2. It then deploys the CouchBase autonomous operator 2.2.0 on the created cluster.  

---

## Table of Contents

1. [Prerequisite](#prerequisite)
2. [Terraform](#terraform)
3. [Deployment](#deployment)

---

## Prerequisite

Before running these automation scripts, you will need to install:
1. [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#install-terraform)
2. [OC CLI Tool](https://docs.openshift.com/container-platform/4.7/cli_reference/openshift_cli/getting-started-cli.html#installing-openshift-cli)

---

## Terraform

To run your terraform scripts, you would need to first provide your ```default``` variable values for both the [VPC/Cluster](arch-roks-with-kms/variables.tf) and [CB Operator](cb-operator-automation/variables.tf) ```variables.tf``` files. Then navigate to the folder containing your terraform scripts and run the following commands:

1. ``` terraform init ``` - initialize your terraform workspace
2. ``` terraform plan ``` - preview resource to be created
3. ```echo "yes" | terraform apply``` - confirm and create your resources
   
Reference the [terraform project build instructions](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#initialize-the-directory) for more details.

---

## Deployment

This deployment pattern is separated into two phases. You will need to deploy the [VPC/Cluster](./arch-roks-with-kms/README.md) then [CB Operator](cb-operator-automation/README.md) in that specific order. To do so, first navigate to the ```arch-roks-with-kms``` directory and follow the steps outlined in the [Terraform](##Terraform) section. Then navigate to the ```cb-operator-automation``` directory and follow the steps outlined in the [Terraform](##Terraform) section.

*Note - You are able to run the ```cb-operator-automation``` with an existing ROKS cluster.