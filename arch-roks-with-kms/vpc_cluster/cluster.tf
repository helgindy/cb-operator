##############################################################################
# Create IKS on VPC Cluster
##############################################################################

resource ibm_container_vpc_cluster cluster {

  name                 = var.cluster_name
  vpc_id               = var.vpc_id
  resource_group_id    = var.resource_group_id
  flavor               = var.machine_type
  entitlement          = var.entitlement
  worker_count         = var.workers_per_zone
  kube_version         = var.kube_version != "" ? var.kube_version : null
  tags                 = var.tags
  wait_till            = var.wait_till
  force_delete_storage = true

  kms_config {
      instance_id      = var.kms_id
      crk_id           = var.kms_key_id
      private_endpoint = true 
  }

  dynamic zones {
    for_each = var.subnets
    content {
      subnet_id = zones.value.id
      name      = zones.value.zone
    }
  }
  cos_instance_crn                = var.cos_instance_crn
  disable_public_service_endpoint = var.disable_public_service_endpoint
}

##############################################################################


##############################################################################
# Worker Pools
##############################################################################

module worker_pools {
  source            = "./worker_pools"
  ibm_region        = var.ibm_region
  pool_list         = var.worker_pools
  vpc_id            = var.vpc_id
  resource_group_id = var.resource_group_id
  cluster_name_id   = ibm_container_vpc_cluster.cluster.id
  subnets           = var.subnets
}

##############################################################################


##############################################################################
# Attach observability - logdna
##############################################################################

resource "ibm_ob_logging" "logdna_iks_attachment" {

  cluster          = ibm_container_vpc_cluster.cluster.id
  instance_id      = var.logdna
  private_endpoint = true
}

##############################################################################

##############################################################################
# Attach observability - sysdig
##############################################################################

resource "ibm_ob_monitoring" "sysdig_iks_attachment" {
  cluster          = ibm_container_vpc_cluster.cluster.id
  instance_id      = var.sysdig
  private_endpoint = true
}

##############################################################################