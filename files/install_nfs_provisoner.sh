#!/bin/bash
oc project default
oc create -f ./files/nfs-provisoner/rbac.yaml
oc adm policy add-scc-to-user hostmount-anyuid system:serviceaccount:default:nfs-client-provisioner
oc create -f ./files/nfs-provisoner/deployment.yaml
oc create -f ./files/nfs-provisoner/class.yaml
echo "success"