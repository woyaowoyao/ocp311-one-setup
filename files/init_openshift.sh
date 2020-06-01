#!/bin/bash
OPENSHIFT_TEMPLATE_DIR='./openshift-templates'
CICD_TEMPLATES=(gogs gitlab nexus3 sonarqube easymock kelk zalenium apollo openldap)
OPENSHIFT_TEMPLATES=(redis-persistent postgresql-persistent mysql-persistent jenkins-ephemeral rabbitmq kafka mongodb dubbo memcached nginx pxc)

# create project CI
oc get project cicd > /dev/null 2>&1  || oc new-project cicd --display-name="CICD持续集成"

# 设置权限
oc get serviceaccount cicd -n cicd > /dev/null 2>&1 || oc create serviceaccount cicd -n cicd && oc adm policy add-scc-to-user anyuid -z cicd -n cicd

for temp_name in "${CICD_TEMPLATES[@]}"
do 
	oc get template $temp_name -n cicd  > /dev/null 2>&1  || oc create -f ${OPENSHIFT_TEMPLATE_DIR}/${temp_name}-template.yaml -n cicd
done


for temp_name in "${OPENSHIFT_TEMPLATES[@]}"
do 
	oc get template $temp_name -n openshift  > /dev/null 2>&1 || oc create -f ${OPENSHIFT_TEMPLATE_DIR}/${temp_name}-template.yaml -n openshift
done

#删除registry-console模板
oc get template registry-console -n openshift > /dev/null 2>&1 && oc delete template registry-console -n openshift
echo "success"