##############################################################################
# Cluster ID
##############################################################################

output cluster_id {
    description = "ID of cluster created"
    value       = ibm_container_vpc_cluster.cluster.id
}

##############################################################################