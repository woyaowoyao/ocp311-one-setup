#!/bin/bash

setenforce 1
selinux=$(getenforce)
if [ "$selinux" != Enforcing ]
then
	echo "Please setlinux Enforcing"
	exit 10
fi

cat >/etc/sysctl.d/99-elasticsearch.conf <<EOF
vm.max_map_count = 262144
EOF
sysctl vm.max_map_count=262144

export CHANGEREPO=true
if [ $CHANGEREPO == true -a ! -d /etc/yum.repos.d/back ]
then
    cd /etc/yum.repos.d/; mkdir -p back; mv -f *.repo back/; cd -
    cp files/all.repo /etc/yum.repos.d/
    yum clean all
fi


current_path=`pwd`
yum localinstall tools/ansible-2.6.5-1.el7.ans.noarch.rpm -y
ansible-playbook playbook.yml --skip-tags after_task
cd $current_path/openshift-ansible-playbook
ansible-playbook playbooks/prerequisites.yml

## 运行下载镜像
nohup bash ${current_path}/files/pull_cicd_images.sh &

ansible-playbook playbooks/deploy_cluster.yml
oc adm policy add-cluster-role-to-user cluster-admin admin

cd $current_path

ansible-playbook playbook.yml --tags install_nfs
ansible-playbook playbook.yml --tags after_task



