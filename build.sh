#!/bin/bash
set -euxo pipefail

docker build -t "registry.cn-hangzhou.aliyuncs.com/ryyan/websphere-tradition:7.0" .
