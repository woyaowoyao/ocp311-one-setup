#!/bin/bash
master_hostname=$1
systemctl restart nfs
function deploy_app_cicd(){
	t_name=$1
	project_name=$2
	param=$3
	oc get dc $t_name -n $project_name > /dev/null 2>&1 || oc new-app --template=$t_name -n $project_name $param
#	sleep 180
}

deploy_app_cicd gogs  cicd "--param=HOSTNAME=gogs-cicd.apps.$master_hostname"
#deploy_app_cicd nexus3 cicd
#deploy_app_cicd sonarqube cicd

echo "success"
