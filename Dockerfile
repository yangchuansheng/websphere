FROM registry.cn-hangzhou.aliyuncs.com/ryyan/rhel6:6.9
LABEL version="7.0.0.54" description="这是一个 Websphere 服务器" by="Ryan"
LABEL maintainer="yangchuansheng33@gmail.com"

# 替换yum
RUN rpm -qa|grep yum|xargs rpm -e --nodeps
ADD http://mirrors.163.com/centos/6.9/os/x86_64/Packages/python-iniparse-0.3.1-2.1.el6.noarch.rpm /usr/local/src/
ADD http://mirrors.163.com/centos/6.9/os/x86_64/Packages/yum-3.2.29-81.el6.centos.noarch.rpm /usr/local/src/
ADD http://mirrors.163.com/centos/6.9/os/x86_64/Packages/yum-metadata-parser-1.1.2-16.el6.x86_64.rpm /usr/local/src/
ADD http://mirrors.163.com/centos/6.9/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.30-40.el6.noarch.rpm /usr/local/src/
RUN rpm -ivh /usr/local/src/python-iniparse-0.3.1-2.1.el6.noarch.rpm; \
    rpm -ivh /usr/local/src/yum-metadata-parser-1.1.2-16.el6.x86_64.rpm; \
    rpm -ivh /usr/local/src/yum-3.2.29-81.el6.centos.noarch.rpm --force --nodeps; \
    rpm -ivh /usr/local/src/yum-plugin-fastestmirror-1.1.30-40.el6.noarch.rpm --force --nodeps; \
    rm -rf /usr/local/src/*

# 替换yum源
RUN rm -rf /etc/yum.repos.d/*
COPY src/rhel.repo /etc/yum.repos.d/
RUN yum clean all; \
    yum makecache

# 安装websphere依赖
RUN yum -y install gtk-vnc* libvncserver* tigervnc* autoconf* binutils-* compat* elfutils-libelf-devel* elfutils-libs* glibc* gcc* libXp* libstdc++-* libaio* openmotif* rpm-* sysstat* groupinstall chinese-support 

# 准备软件包
ADD WebSphere.tar.gz /opt/IBM/WebSphere/

# 创建
