##############################################################################
# Outputs
##############################################################################

output cos_id {
    description = "ID of COS instance"
    value       = ibm_resource_instance.cos.id
}

output logdna_id {
    description = "ID of LogDNA instance"
    value       = ibm_resource_instance.logdna.guid
}

output logdna_key {
    description = "ID of LogDNA service key"
    value       = ibm_resource_key.logdna_service_key
}

output sysdig_id {
    description = "ID of Sysdig instance"
    value       = ibm_resource_instance.sysdig.guid
}

output sysdig_key {
    description = "ID of Sysdig service key"
    value       = ibm_resource_key.sysdig_service_key
}

output kms_id {
    description = "ID of the KMS instance"
    value       = ibm_resource_instance.kms.guid
}

output kms_key_id {
    description = "Id of the KMS root key"
    value       = ibm_kp_key.root_key.key_id
}

##############################################################################