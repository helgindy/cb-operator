##############################################################################
# Account Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
}

variable "ibm_region" {
  description = "IBM Cloud region where all resources will be deployed"
  type        = string
}

variable "resource_group" {
  description = "Name of resource group where all infrastructure will be provisioned"
  type        = string
}

variable "generation" {
  description = "generation for VPC. Can be 1 or 2"
  type        = number
  default     = 2
}

##############################################################################


##############################################################################
# Cluster Variables
##############################################################################

variable "cluster_name" {
  description = "Name of ROKS cluster to install operator"
  type        = string
}

variable "cluster_project" {
  description = "Name of cluster project to create then install CB operator in"
  type        = string
}

variable "existing_project" {
  description = "Set to true if cluster project exists for operator installation, false otherwise"
  type        = bool
  default     = false
}

##############################################################################


##############################################################################
# Container Image Server Variables
##############################################################################

variable "container_image_server" {
  description = "Container image server endpoint"
  type        = string
  default     = "registry.connect.redhat.com"
}

variable "container_image_username" {
  description = "Container image server username"
  type        = string
  default     = "test"
}

variable "container_image_email" {
  description = "Container image server email address"
  type        = string
  default     = "test@email.com"
}

variable "container_image_password" {
  description = "Container image server password"
  type        = string
  default     = "password"
}

##############################################################################