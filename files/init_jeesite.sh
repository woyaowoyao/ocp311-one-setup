#!/bin/bash
gogs_username=$1
gogs_password=$2
master_hostname=$3
#shell sh init_jeesite.sh  root 123456 demo-jeesite.apps.os311.test.it.example.com
## create token
token=$(curl -s -u root:123456 http://gogs.cicd.svc:3000/api/v1/users/root/tokens | grep sha1 | awk -F\" '{print $8}')
if [ "$token" == "" ]
then
	token=$(curl -s -X POST -u $gogs_username:$gogs_password http://gogs.cicd.svc:3000/api/v1/users/root/tokens -d name=default | awk -F\" '{print $8}')
fi


## create repo
curl -s -H "Authorization: token $token" http://gogs.cicd.svc:3000/api/v1/user/repos | egrep -q '"name":"jeesite"[^{]*"empty":false'
if [ $? -eq 0 ]
then
 	if [ -d jeesite ]
 	then
 		cd jeesite
 		git pull
  	else
		git clone http://gogs.cicd.svc:3000/root/jeesite.git
		cd jeesite
	fi
else
	curl -s -H "Authorization: token $token"  -X POST http://gogs.cicd.svc:3000/api/v1/user/repos -d 'name=jeesite&private=false'
	if [ ! -d jeesite ]
	then
		git clone https://gitee.com/openshiftx/jeesite.git
		cd jeesite
		rm -rf .git
		git init
		git add .
		git commit -m "first commit"
		git remote add origin http://$gogs_username:$gogs_password@gogs.cicd.svc:3000/root/jeesite.git
		git push -u origin master
	else
		git push -u origin master
	fi
	
	curl -X POST \
	  http://gogs.cicd.svc:3000/api/v1/repos/root/jeesite/hooks \
	  -H "authorization: token $token" \
	  -H 'content-type: application/json; charset=UTF-8' \
	  -d '{
	    "type": "gogs",
	    "config": {
	        "content_type": "form",
	        "url": "https://'$master_hostname':8443/apis/build.openshift.io/v1/namespaces/jeesite/buildconfigs/jeesite-pipeline/webhooks/jeesite/generic"
	    },
	    "active": true
	}'

fi

oc get project jeesite  > /dev/null 2>&1 ||  oc new-project jeesite --display-name=JeeSite
oc get dc mysql -n jeesite > /dev/null 2>&1 || oc new-app --template=openshift/mysql-persistent --name=mysql --param=MYSQL_USER=jeesite --param=MYSQL_PASSWORD=jeesite --param=MYSQL_ROOT_PASSWORD=jeesite --param=MYSQL_DATABASE=jeesite -n jeesite

oc get bc jeesite  -n jeesite > /dev/null 2>&1 || cat Dockerfile | oc new-build -D - --name jeesite -n jeesite && oc adm policy add-scc-to-user anyuid -z jeesite -n jeesite
oc get bc jeesite-pipeline  -n jeesite > /dev/null 2>&1 || oc create -f openshift-pipeline.yml -n jeesite

oc get serviceaccount jeesite -n jeesite 2>&1 || oc create serviceaccount jeesite -n jeesite
oc get dc jeesite > /dev/null 2>&1 || oc create -f ../openshift-templates/jeesite-deployment.yaml -n jeesite
oc get svc jeesite > /dev/null 2>&1 || oc expose dc jeesite --port=8080
oc get route jeesite > /dev/null 2>&1 || oc expose svc jeesite
echo "success"