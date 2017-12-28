# WebSphere Application Server 7.0 and Docker

+ Dockerfile 用来构建完整的 was 7.0 镜像
+ 由于 was 的安装包过于庞大，在实际使用中可以将 was 镜像中的 Websphere 目录删除，启动容器时整个 Websphere 目录通过 volume 的形式从宿主机挂载到容器中。Dockerfile.nodata 用来构建没有 Websphere 目录的镜像

## 平台实际情况

> Dockerfile对应的镜像 --> 10.20.3.65/daocloud/was:standalone <br /> Dockerfile.nodata对应的镜像 --> 10.20.3.65/daocloud/was:base

+ 总共有10个 *dce 节点*，每台 *dce 节点*上启动3个 was 容器，每个 was 容器都是单节点版（非集群版），启动脚本为：/root/start_was.sh
+ 由于他们的认证机制需要绑定容器的 mac 地址，所以不能通过 service 的形式来部署 was 应用，只能通过单节点的形式来启动
+ 每台节点上的 was 容器挂载宿主机的目录分别为/data/Websphere1、/data/Websphere2、/data/Websphere3,这三个目录均是一模一样的内容，同时其他节点上的目录内容也要保持相同（具体做法是：先启动一个 was 容器，让 was 那边的工程师进行操作，包括添加修改配置，等测试调通后再把这个容器的存储目录复制给其他的 was 容器使用）
+ tomcat 和 nginx 均通过 service 的形式部署，存储都挂到宿主机的指定目录下，具体配置可到 dce 控制台查看
