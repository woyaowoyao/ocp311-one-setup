## 安装Istio
> 1. 拉取所需镜像
```
$ ./docker-pull-images.sh
```
> 2. 部署istio operator
```
$ oc new-project istio-operator
$ oc new-app -f istio_product_operator_template.yaml --param=OPENSHIFT_ISTIO_MASTER_PUBLIC_URL=https://os311.test.it.example.com:8443
```
- OPENSHIFT_ISTIO_MASTER_PUBLIC_URL为openshift集群对外的master地址，例如：https://os311.test.it.example.com:8443
- OPENSHIFT_ISTIO_PREFIX为openshift istio的镜像前缀，如果将准备中的镜像都导入到了自己的私有仓库中，就可以使用它换成自己的镜像仓库地址
> 3. 部署istio
```
$ oc create -f istio-installation.yaml -n istio-operator
```
> 4. 配置master-config，使得新建pod自动注入istio-proxy sidecar
```
$ cp master-config.patch  /etc/origin/master/master-config.patch
$ cd /etc/origin/master/
$ cp -p master-config.yaml master-config.yaml.prepatch
$ oc ex config patch master-config.yaml.prepatch -p "$(cat master-config.patch)" > master-config.yaml
$ /usr/local/bin/master-restart api && /usr/local/bin/master-restart controllers
```
