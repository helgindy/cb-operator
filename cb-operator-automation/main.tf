##############################################################################
# Data object for ROKS cluster
##############################################################################

data "ibm_container_cluster_config" "roks_cluster" {
  cluster_name_id   = var.cluster_name
  resource_group_id = data.ibm_resource_group.group.id
  admin             = true
}

##############################################################################


##############################################################################
# Install CB Operator installation
##############################################################################

data "ibm_resource_group" "group" {
  name = var.resource_group
}

##############################################################################


##############################################################################
# Install CB Operator installation
##############################################################################
resource "null_resource" "cb_install" {
  depends_on = [data.ibm_container_cluster_config.roks_cluster]
  triggers = {
    kubeconfig = data.ibm_container_cluster_config.roks_cluster.config_file_path
  }
  provisioner "local-exec" {
    command = <<BASH
echo "CouchBase cluster creation started"

export KUBECONFIG=${data.ibm_container_cluster_config.roks_cluster.config_file_path}

if ${var.existing_project}
then
  echo "Switching to existing project"
  oc project ${var.cluster_project}
else
  echo "Creating and switching to project ${var.cluster_project}"
  oc new-project ${var.cluster_project}
fi

echo "Creating CouchBase custom resource definitions"

oc create -f ${path.module}/couchbase-autonomous-operator-openshift_2.2.0-macos-x86_64/crd.yaml 

echo "Creating container catalog secret"

oc create secret docker-registry rh-catalog --docker-server=${var.container_image_server} \
  --docker-username=${var.container_image_username} --docker-password=${var.container_image_password} --docker-email=${var.container_image_email}

echo "Creating and waiting for operator and dynamic admission controller"

${path.module}/couchbase-autonomous-operator-openshift_2.2.0-macos-x86_64/bin/cbopcfg generate admission --image-pull-secret rh-catalog | oc create -f -

${path.module}/couchbase-autonomous-operator-openshift_2.2.0-macos-x86_64/bin/cbopcfg generate operator --image-pull-secret rh-catalog | oc create -f -

while true
do
  echo "Waiting on operator and DAC"
  sleep 5
  if [[ $(oc get pods | grep -c "0/1") -gt 0 ]]
  then
    continue
  else
    break
  fi
done

echo "Creating CouchBase cluster"

oc create -f ${path.module}/couchbase-autonomous-operator-openshift_2.2.0-macos-x86_64/couchbase-cluster.yaml 

oc wait -f ${path.module}/couchbase-autonomous-operator-openshift_2.2.0-macos-x86_64/couchbase-cluster.yaml --for=condition=complete

echo "CouchBase cluster creation complete"
    BASH
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<BASH
echo "CouchBase cluster destruction started"

export KUBECONFIG=${self.triggers.kubeconfig}

echo "Destroying CB cluster"

oc delete -f ${path.module}/couchbase-autonomous-operator-openshift_2.2.0-macos-x86_64/couchbase-cluster.yaml

echo "Destroying operator and DAC"

${path.module}/couchbase-autonomous-operator-openshift_2.2.0-macos-x86_64/bin/cbopcfg delete operator

${path.module}/couchbase-autonomous-operator-openshift_2.2.0-macos-x86_64/bin/cbopcfg delete admission

echo "Deleting image server secret"

oc delete secret rh-catalog

echo "Destroying CB custom resource definition"

oc delete -f ${path.module}/couchbase-autonomous-operator-openshift_2.2.0-macos-x86_64/crd.yaml

echo "CouchBase cluster destruction complete"
    BASH
  }
}
##############################################################################
