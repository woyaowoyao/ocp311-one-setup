#!/bin/bash
CICD_IMAGES=(
	openshift/origin-node:v3.11.0 \
	openshift/origin-pod:v3.11.0 \
	xhuaustc/nfs-client-provisioner:latest \
	gitlab/gitlab-ce:11.4.0-ce.0 \
	redis:3.2.3-alpine \
	centos/postgresql-95-centos7:latest \
	openshiftdemos/gogs:0.11.34 \
	openshift/jenkins-2-centos7:latest \
	sonatype/nexus3:3.18.1 \
	openshift/jenkins-agent-maven-35-centos7:v3.11 \
	openshiftdemos/sonarqube:7.0 \
	centos/mysql-57-centos7:latest \
	xhuaustc/openshift-kafka:latest \
	xhuaustc/openshift-kafka:latest \
	xhuaustc/logstash:6.6.1 \
	xhuaustc/elasticsearch:6.6.1 \
	xhuaustc/zalenium:3 \
	xhuaustc/selenium:3 \
	xhuaustc/kibana:6.6.1 \
	rabbitmq:3.7-management \
	curiouser/dubbo_zookeeper:v1 \
	blackcater/easy-mock:1.6.0 \
	mongo:4.1 \
	redis:5 \
	tomcat:8.5-alpine \
	xhuaustc/apolloconfigadmin:latest \
	xhuaustc/apolloportal:latest \
	memcached:1.5 \
	perconalab/proxysql-openshift:0.5 \
	perconalab/pxc-openshift:latest \
	centos/nginx-112-centos7:latest \
	xhuaustc/openldap-2441-centos7:latest)

for image in "${CICD_IMAGES[@]}"
do
	docker pull $image
done