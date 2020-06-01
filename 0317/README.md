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
    
    cd openshift-oneclick-allinone
    
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



补充说明：
https://blog.51cto.com/shunzi115/2425766
开发工具： Ansible + Shell

步骤:
环境：

CentOS 7.5 CPU > 2core, Memory > 4G

 yum -y install NetworkManager git 

 systemctl start NetworkManager;systemctl status NetworkManager;

 git clone https://gitee.com/5151000/OpenshiftOneClick.git

 cd OpenshiftOneClick.git

运行部署(必须切到root账号)

 sudo su

 /bin/bash deploy_openshift.sh

本地绑定hosts

 HOSTNAME 默认为os311.test.it.example.com

cat /etc/hosts

192.168.61.140 os311.test.it.example.com

浏览器访问

https://os311.test.it.example.com:8443

#安装maven-end
wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
解压改名
tar zxf apache-maven-3.6.3-bin.tar.gz 
mv apache-maven-3.6.3 /usr/local/maven3
vi /etc/profile
#然后还需要 配置环境变量。
#在适当的位置添加
export M2_HOME=/usr/local/maven3
export PATH=$PATH:$JAVA_HOME/bin:$M2_HOME/bin
 
保存退出后运行下面的命令使配置生效，或者重启服务器生效。
source /etc/profile
 
安装maven-end

# 安装jdk-start
yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel
获取java home

dirname $(readlink $(readlink $(which java))) 

设置环境变量
vim /etc/profile.d/env_export.sh

在新建的文件中填写

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.242.b08-0.el7_7.x86_64
#上面dirname命令获取到的路径，不要bre/bin最后这段
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar

source /etc/profile.d/env_export.sh
安装jdk-end
cat > /etc/profile.d/java8.sh <<EOF 
export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
export PATH=\$PATH:\$JAVA_HOME/bin
export CLASSPATH=.:\$JAVA_HOME/jre/lib:\$JAVA_HOME/lib:\$JAVA_HOME/lib/tools.jar
EOF