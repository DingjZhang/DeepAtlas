#!/bin/bash

# 获取节点名称
NODE_NAME=$(microk8s kubectl get no -o jsonpath='{.items[0].metadata.name}')

# 为节点添加标签
microk8s kubectl label nodes $NODE_NAME location=onprem --overwrite

echo "已为节点 $NODE_NAME 添加标签 location=onprem"
