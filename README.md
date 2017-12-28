# WebSphere Application Server 7.0 and Docker

+ Dockerfile 用来构建完整的 was 7.0 镜像
+ 由于 was 的安装包过于庞大，在实际使用中可以将 was 镜像中的 Websphere 目录删除，启动容器时整个 Websphere 目录通过 volume 的形式从宿主机挂载到容器中，宿主机的挂载路径为/data/Websphere。Dockerfile.nodata 用来构建没有 Websphere 目录的镜像
