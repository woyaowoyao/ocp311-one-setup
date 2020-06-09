一键部署Openshift 3.11
#### 可配置项：
查看config.yml文件

    CHANGEREPO: true
    HOSTNAME: os311.test.it.example.com

    Change_Base_Registry: false
    Harbor_Url: harbor.apps.it.example.com

    FULL_INSTALL: false
    SAMPLE_TEMPLATES: true

    CICD_INSTALL: false

说明:
- CHANGEREPO: 是否使用files/all.repo替换系统默认repo源
- HOSTNAME：安装Openshift的主机的hostname，也是集群的访问域名
- Change_Base_Registry：是否使用私有镜像仓库
- Harbor_Url：私有镜像仓库地址，Change_Base_Registry为True时有效
- FULL_INSTALL：是否全量安装（包括日志，监控等）
- SAMPLE_TEMPLATES: 是否安装Openshift默认的模板
- CICD_INSTALL: 是否安装CICD应用工具链

安装步骤如下：
#### 1. 准备一台主机/虚拟机(CentOS 7.4以上, CPU > 2core, Memory > 4G)

#### 2. 将一键部署脚本拷贝到主机上

#### 3. cd到openshift-oneclick-allinone目录
    # yum -y install NetworkManager git 
# systemctl start NetworkManager;systemctl status NetworkManager;
# git clone https://github.com/woyaowoyao/ocp311-one-setup.git
    cd ocp311-one-setup
    
#### 4. 运行部署(必须切到root账号)

    sudo su
    /bin/bash deploy_openshift.sh
    
#### 5. 本地绑定hosts
    <ip> os311.test.it.example.com
#### 6. 浏览器访问
    https://os311.test.it.example.com:8443
![CICD工具应用](https://images.gitee.com/uploads/images/2018/1211/180618_90ca6ea4_550732.png "屏幕截图.png")

![自动创建Pipeline](https://images.gitee.com/uploads/images/2018/1211/180737_038ab5ba_550732.png "屏幕截图.png")

![测试pipeline应用](https://images.gitee.com/uploads/images/2018/1211/181107_da9cea98_550732.png "屏幕截图.png")
用户名：admin  密码：admin

https://blog.51cto.com/shunzi115/2425766

https://access.redhat.com/documentation/en-us/openshift_container_platform/3.11/html/developer_guide/deployments
https://training-lms.redhat.com/lmt/lmtLogin.prMenu?in_sessionid=20334J40089A8230
https://www.bugclose.com/console.html
http://www.ansible.com.cn/
https://docs.openshift.com/container-platform/3.11/install/configuring_inventory_file.html
https://access.redhat.com/articles/433903
https://www.cnblogs.com/ericnie/p/11437529.html
https://www.jianshu.com/p/3b83374afee7

zip -r m2.zip /root/.m2/
oc import-image gogs  --confirm  --reference-policy='local' --from docker.io/openshiftdemos/gogs:0.11.34 
 
